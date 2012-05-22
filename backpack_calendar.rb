require 'net/https'
require 'date'
require 'time'
require 'uri'

begin
  require 'xmlsimple'
rescue LoadError
  begin
    require 'rubygems'
    require_gem 'xml-simple'
  rescue LoadError
    abort <<-ERROR
The 'xml-simple' library could not be loaded. If you have RubyGems installed
you can install xml-simple by doing "gem install xml-simple".
ERROR
  end
end

module Backpack
  # An interface to the Backpack calendar web-services API.
  #
  #   session = Backpack::Calendar.new('http://your.backpackit.com', 'token')
  #
  # Note: Be sure to enter https:// if your account is over SSL.
  class Calendar
    attr_reader :token

    def initialize(host, token)
      @host, @token = host, token
      @requester    = WebServiceRequester.new(host)
      @requester.client = self
    end

    #================
    # Calendars
    #================

    # Returns all calendars for the current account.
    #
    #   session.calendars
    #   => [#<Record(calendar) "name"=>"Personal"...>, ...]
    def calendars
      records 'calendar', '/calendars.xml', :method => :get
    end

    #================
    # Calendar Events
    #================

    # Returns all events for the given calendar_id.
    #
    #   session.calendar_events(5)
    #   => [#<Record(calendar-event) "title"=>"birthday dinner with mom" ...>]
    def calendar_events(calendar_id)
      records "/calendars/#{calendar_id}/calendar_events.xml", :method => :get
    end

    # Returns the event with the given event_id.
    #
    #   event = session.calendar_event(35)
    #   => #<Record(calendar-event) "title"=>"birthday dinner with mom" ...>
    #   event.title
    #   => "birthday dinner with mom at North Pond"
    def calendar_event(event_id)
      record "/calendar_events/#{event_id}.xml", :method => :get
    end

    # Create a new calendar event for the given calendar. The event parameter should be
    # a hash. The :title key is required for the +event+ hash.
    # A minimal calendar event creation would look something like this:
    #
    #   session.post_calendar_event(5, :title => '9/27 birthday dinner with mom at North Pond')
    #   => "http://marcel.backpackit.com/calendar_events/329.xml"
    #
    # If the calendar event is succesfully created, the url of the new event will be returned.
    # Otherwise +false+ will be returned.
    #
    #   session.calendar_event(329).title
    #   => "birthday dinner with mom at North Pond"
    def post_calendar_event(calendar_id, event)
      @requester.make_request(:post, "/calendar_events.xml", :event => event.merge(:calendar_id => calendar_id))

      if @requester.code == 201
        @requester.response['Location']
      else
        false
      end
    end

    private

      def record(*args, &block)
        @requester.record(*args, &block)
      end

      def records(*args, &block)
        @requester.records(*args, &block)
      end
  end
end

class WebServiceRequesterError < StandardError
end

class WebServiceRequester
  
  # Results are wrapped in instances of this Record class. 
  class Record #:nodoc:
    attr_reader :type

    def initialize(type, hash)
      @type = type
      @hash = hash
    end

    def [](name)
      name = name.to_s.dasherize
      case @hash[name]
        when {"nil" => true} then nil
        when Hash then 
          @hash[name] = (@hash[name].keys.length == 1 && Array === @hash[name].values.first) ?
            @hash[name].values.first.map { |v| Record.new(@hash[name].keys.first, v) } :
            Record.new(name, @hash[name])
        else @hash[name]
      end
    end

    def id
      @hash['id']
    end

    def attributes
      @hash.keys
    end

    def respond_to?(sym)
      super || @hash.has_key?(sym.to_s.dasherize)
    end

    def method_missing(sym, *args)
      if args.empty? && !block_given? && respond_to?(sym)
        self[sym]
      else
        super
      end
    end

    def to_s
      "\#<Record(#{@type}) #{@hash.inspect[1..-2]}>"
    end
    alias_method :inspect, :to_s

  end

  # In the event of a 302 response code, if try again is true, the request will
  # be attempted a second time using the opposite of whatever the ssl setting had
  # been in the first attempt.
  attr_accessor :try_again
  attr_accessor :client
  attr_reader   :response
  
  def initialize(url)
    uri = URI.parse(url)
    if uri.host
      @host          = uri.host
      port           = uri.port
      use_ssl        = !uri.scheme[/s$/].nil?
      @try_again     = true
      yield self if block_given?
      connect!(use_ssl, port)
    else
      raise "Couldn't extract host from #{url.inspect}"
    end
  end

  # Make a raw web-service request. This will return a Hash of
  # Arrays of the response, and may seem a little odd to the uninitiated.
  def request(path, parameters = {}, second_try = false)
    method = parameters.delete(:method) || :put
    @response = make_request(method, path, parameters)

    if success?
      return true if response.body.to_s.strip.empty?
      result = XmlSimple.xml_in(response.body, 'keeproot' => true,
        'contentkey' => '__content__', 'forcecontent' => true)
      typecast_value(result)
    elsif try_again && code == 302 && !second_try
      begin
        connect!(!@connection.use_ssl)
        request(path, parameters, true)
      rescue Errno::ECONNREFUSED
        raise WebServiceRequesterError, "Error occured (#{code}): #{response.body}"
      end
    else
      raise WebServiceRequesterError, "Error occured (#{code}): #{response.body}"
    end
  end

  # A convenience method for wrapping the result of a query in a Record
  # object. This assumes that the result is a singleton, not a collection.
  def record(path, parameters={})
    @result = request(path, parameters)
    (@result && !@result.empty?) ? Record.new(@result.keys.first, @result.values.first) : nil
  end

  # A convenience method for wrapping the result of a query in Record
  # objects. This assumes that the result is a collection--any singleton
  # result will be wrapped in an array.
  def records(node, path, parameters={})
    result = request(path, parameters) or return []
    result = result.values.first or return []
    result = result[node] or return []
    result = [result] unless Array === result
    result.map { |row| Record.new(node, row) }
  end

  def code
    response.code.to_i if response
  end

  def message
    response.message if response
  end

  {:success => 200..299, :redirect => 300..399, 
   :missing => 400..499, :error    => 500..599}.each do |result, code|
    define_method("#{result}?") do
      return false unless response
      code.include? response.code.to_i
    end
  end

  def make_request(method, path, parameters, header = {})
    requester = Net::HTTP.const_get(method.to_s.capitalize)
    @request   = requester.new(path, header.merge("Content-Type" => 'application/xml', 'X-BP-Token' => client.token))
    @response = @connection.request(@request, convert_body(parameters))
  end
  
  private

    def connect!(use_ssl = false, port = 80)
      @connection = Net::HTTP.new(@host, use_ssl ? 443 : port)
      @connection.use_ssl = use_ssl
      @connection.verify_mode = OpenSSL::SSL::VERIFY_NONE if use_ssl
    end

    def convert_body(body)
      return '' if body.empty?
      if body.respond_to?(:keys) && body.keys.size == 1 && (root = body.keys.first).respond_to?(:to_xml)
        root = body.keys.first
        body[root].to_xml(:root => root.to_s)
      else
        body.to_xml
      end
    end

    def typecast_value(value)
      case value
      when Hash
        if value.has_key?("__content__")
          content = translate_entities(value["__content__"])
          case value["type"]
          when "integer"  then content.to_i
          when "boolean"  then content == "true"
          when "datetime" then Time.parse(content)
          when "date"     then Date.parse(content)
          else                 content
          end
        else
          value.empty? ? nil : value.inject({}) do |h,(k,v)|
            h[k] = typecast_value(v)
            h
          end
        end
      when Array
        value.map! { |i| typecast_value(i) }
        case value.length
        when 0 then nil
        when 1 then value.first
        else value
        end
      when 'true'
        true
      else
        raise "can't typecast #{value.inspect}"
      end
    end

    def translate_entities(value)
      value.gsub(/&lt;/, "<").
            gsub(/&gt;/, ">").
            gsub(/&quot;/, '"').
            gsub(/&apos;/, "'").
            gsub(/&amp;/, "&")
    end
end

# A minor hack to let Xml-Simple serialize symbolic keys in hashes
class Symbol
  def [](*args)
    to_s[*args]
  end
end

class Hash
  def to_xml
    XmlSimple.xml_out({:request => self}, 'keeproot' => true, 'noattr' => true)
  end
end

class String
  def dasherize
    gsub('_', '-')
  end
end
