# Requires that XmlSimple is already loaded.
# Author: David Heinemeier Hansson, 37signals

require 'yaml'
require 'net/https'

class Backpack
  attr_accessor :username, :token, :current_page_id

  def initialize(username, token)
    @username, @token = username, token
    connect
  end

  def connect(use_ssl = false)
    @connection = Net::HTTP.new("#{@username}.backpackit.com", use_ssl ? 443 : 80)
    @connection.use_ssl = use_ssl
    @connection.verify_mode = OpenSSL::SSL::VERIFY_NONE if use_ssl
  end

  def page_id=(id)
    self.current_page_id = id
  end

  def request(path, parameters = {}, second_try = false)
    parameters = { "token" => @token }.merge(parameters)

    response = @connection.post("/ws/#{path}", parameters.to_yaml, "X-POST_DATA_FORMAT" => "yaml")

    if response.code == "200"
      result = XmlSimple.xml_in(response.body)
      result.delete "success"
      result.empty? ? true : result
    elsif response.code == "302" && !second_try
      connect(true)
      request(path, parameters, true)
    else
      raise "Error occured (#{response.code}): #{response.body}"
    end
  end


  # Items ----

  def list_items(page_id = current_page_id)
    request "page/#{page_id}/items/list"
  end

  def create_item(content, page_id = current_page_id)
    request "page/#{page_id}/items/add", "item" => { "content" => content }
  end

  def update_item(item_id, content, page_id = current_page_id)
    request "page/#{page_id}/items/update/#{item_id}", "item" => { "content" => content }
  end

  def destroy_item(item_id, page_id = current_page_id)
    request "page/#{page_id}/items/destroy/#{item_id}"
  end

  def toggle_item(item_id, page_id = current_page_id)
    request "page/#{page_id}/items/toggle/#{item_id}"
  end

  def move_item(item_id, direction, page_id = current_page_id)
    request "page/#{page_id}/items/move/#{item_id}", "direction" => "move_#{direction}"
  end


  # Notes ----

  def list_notes(page_id = current_page_id)
    request "page/#{page_id}/notes/list"
  end

  def create_note(title, body, page_id = current_page_id)
    request "page/#{page_id}/notes/create", "note" => { "title" => title, "body" => body }
  end

  def update_note(note_id, title, body, page_id = current_page_id)
    request "page/#{page_id}/notes/update/#{note_id}", "note" => { "title" => title, "body" => body }
  end

  def destroy_note(note_id, page_id = current_page_id)
    request "page/#{page_id}/notes/destroy/#{note_id}"
  end


  # Separators (dividers) ----

  def create_separator(name, page_id = current_page_id)
    request "page/#{page_id}/separators/create", "separator" => { "name" => name }
  end

  def update_separator(separator_id, name, page_id = current_page_id)
    request "page/#{page_id}/separators/update/#{separator_id}", "separator" => { "name" => name }
  end

  def destroy_separator(separator_id, page_id = current_page_id)
    request "page/#{page_id}/separators/destroy/#{separator_id}"
  end


  # Emails ----

  def list_emails(page_id = current_page_id)
    request "page/#{page_id}/emails/list"
  end

  def show_email(email_id, page_id = current_page_id)
    request "page/#{page_id}/emails/show/#{email_id}"
  end

  def destroy_email(email_id, page_id = current_page_id)
    request "page/#{page_id}/emails/destroy/#{email_id}"
  end


  # Tags ----

  def list_pages_with_tag(tag_id)
    request "tags/select/#{tag_id}"
  end

  def tag_page(tags, page_id = current_page_id)
    request "page/#{page_id}/tags/tag", "tags" => tags
  end


  # Pages ----

  def list_pages
    request "pages/all"
  end

  def create_page(title, body)
    request "pages/new", "page" => { "title" => title, "description" => body }
  end

  def show_page(page_id = current_page_id)
    request "page/#{page_id}"
  end

  def reorder_page(belonging_ids, page_id = current_page_id)
    belonging_ids *= ' ' unless belonging_ids.is_a?(String)
    request "page/#{page_id}/destroy", 'belongings' => belonging_ids
  end

  def destroy_page(page_id = current_page_id)
    request "page/#{page_id}/destroy"
  end

  def update_title(title, page_id = current_page_id)
    request "page/#{page_id}/update_title", "page" => { "title" => title }
  end

  def update_body(body, page_id = current_page_id)
    request "page/#{page_id}/update_body", "page" => { "description" => body }
  end

  def link_page(linked_page_id, page_id = current_page_id)
    request "page/#{page_id}/link", "linked_page_id" => linked_page_id
  end

  def unlink_page(linked_page_id, page_id = current_page_id)
    request "page/#{page_id}/unlink", "linked_page_id" => linked_page_id
  end

  def share_page(email_addresses, public_page = nil, page_id = current_page_id)
    parameters = { "email_addresses" => email_addresses }
    parameters = parameters.merge({ "page" => { "public" => public_page ? "1" : "0" }}) unless public_page.nil?
    request "page/#{page_id}/share", parameters
  end


  # Reminders ---

  def list_reminders
    request "reminders"
  end

  def create_reminder(content, remind_at = "")
    request "reminders/create", "reminder" => { "content" => content, "remind_at" => remind_at }
  end

  def update_reminder(reminder_id, content, remind_at)
    request "reminders/update/#{reminder_id}", "reminder" => { "content" => content, "remind_at" => remind_at }
  end

  def destroy_reminder(reminder_id)
    request "reminders/destroy/#{reminder_id}"
  end
end
