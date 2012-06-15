Backpack API
============

The Backpack API is implemented as vanilla XML over HTTP.


Authentication
--------------

Authentication happens by accessing a url that belongs to the user, like http://david.backpackit.com, and by passing in the web service token as part of the XML request. The token is a 40-char SHA1 hash and can be found on your "My Info" page. The token represents your password for use with web services, so don't distribute it - that would be like giving your password away. Abuse the token and it can be revoked.

If you're making a public integration with Backpack for others to enjoy, you can also use OAuth 2. This allows users to authorize your application to use Basecamp Classic on their behalf without having to copy/paste API tokens or touch sensitive login info.

Read the [37signals API Authentication Guide](https://github.com/37signals/api/tree/master/sections/authentication.md) for more info on using OAuth.


Making requests
---------------

Send the `Content-Type: application/xml` header to identify XML requests. Here's an example with curl:

    curl -H 'Content-Type: application/xml' -d '<request>
      <token>40bd001563085fc35165329ea1ff5c5ecbdbbeef</token>
    </request>' \
    http://david.backpackit.com/ws/page/1

This request will return something like:

``` xml
<response success='true'>
<page title='Ajax Summit' id='1133' email_address='ry87ib@backpackit.com'>

  <notes>
    <note title='Hotel' id='1020' created_at='2005-05-14 16:41:11'>
      Staying at the Savoy
    </note>
  </notes>

  <lists>
    <list id='2592' name='Itinerary'>
      <items>
        <item id='3308' completed='false'>See San Francisco</item>
        <item id='3303' completed='true'>Meet interesting people</item>
        <item id='3307' completed='true'>Present Backpack</item>

      </items>
    </list>
  </lists>

  <tags>
    <tag name='Technology' id='4' />
    <tag name='Travel' id='5' />
  </tags>
</page>
</response>
```

Complete post example with Curl:

    curl -H 'Content-Type: application/xml' -d '<request>
      <token>40bd001563085fc35165329ea1ff5c5ecbdbbeef</token>

      <item>
        <content>Hello World!</content>
      </item>
    </request>' \
    http://david.backpackit.com/ws/page/1/items/create

...will return something like:

``` xml
<response success='true'>
  <item completed='false' id='5'>Hello World!</item>
</response>
```

If something goes wrong in the request, you’ll get one of two errors. This one for an internal error, which may occur if you pass in bad variables:

``` xml
<response success='false'>
  <error code='500'>Internal error</item>
</response>
```

...or this one, if you’re referencing a record that doesn’t exist:

``` xml
<response success='false'>
  <error code='404'>Record not found</item>
</response>
```

The API returns HTTP status code `200 OK` when succesful unless otherwise noted.

API Endpoints
-------------

* [Pages](https://github.com/37signals/backpack-api/blob/master/sections/pages.md)
* [Lists](https://github.com/37signals/backpack-api/blob/master/sections/lists.md)
* [List Items](https://github.com/37signals/backpack-api/blob/master/sections/list_items.md)
* [Notes](https://github.com/37signals/backpack-api/blob/master/sections/notes.md)
* [Separators](https://github.com/37signals/backpack-api/blob/master/sections/separators.md)
* [Tags](https://github.com/37signals/backpack-api/blob/master/sections/tags.md)
* [Reminders](https://github.com/37signals/backpack-api/blob/master/sections/reminders.md)
* [Emails](https://github.com/37signals/backpack-api/blob/master/sections/emails.md)
* [Status](https://github.com/37signals/backpack-api/blob/master/sections/status.md)
* [Journal](https://github.com/37signals/backpack-api/blob/master/sections/journal.md)
* [Users](https://github.com/37signals/backpack-api/blob/master/sections/users.md)
* [Bookmarks](https://github.com/37signals/backpack-api/blob/master/sections/bookmarks.md)
* [Calendars](https://github.com/37signals/backpack-api/blob/master/sections/calendars.md)
* [Calendar Events](https://github.com/37signals/backpack-api/blob/master/sections/calendar_events.md)

(Hint: Press `t` to enable the file finder and type out the endpoint you need!)

Need a sample of each XML blob will look like? Check out the [Data Reference](https://github.com/37signals/backpack-api/blob/master/sections/data_reference.md).


SSL Usage
---------

A non-SSL request made against an account that has SSL enabled (and vice versa) will receive a "302 Found" response. The Location header will contain the correct URI.

If SSL is enabled for your account, ensure that you're using https. If it's not, ensure you're using http.


Usage Limits
------------

API requests rates are tracked by account subdomain and incoming IP address, so they're per-customer and per-client. If your application uses the API from a cluster of machines, that's fine; just be reasonable. Calendar API requests are limited to 10 requests per 5 seconds. All other requests are limited to 100 requests per 5 seconds. If you exceed the limit, you'll get a 503 response with a Retry-After header indicating how many seconds to wait until retry.


Wrappers and example code
-------------------------

* Ruby: [Example wrapper](https://github.com/37signals/backpack-api/blob/master/ruby_wrapper.rb), [Example calendar wrapper](https://github.com/37signals/backpack-api/blob/master/backpack_calendar.rb)
* Perl: [Net::Backpack](http://search.cpan.org/dist/Net-Backpack/)
* Emacs: [backpack.el](http://github.com/hober/37emacs/blob/master/backpack.el)

Wrote your own API wrapper? Feel free to open a pull request and add to this list!


Documentation Conventions
-------------------------

To make things easier to understand, the following notation is used:

* `#{text}`: Indicates text that should be replaced by your own data
* `...`: Indicates content from the response has been elided for brevity in documentation. See the list of data responses at the end of the page for a full description of the format of that response type.


Help us make it better
----------------------

Please tell us how we can make this API better. If you have a specific feature request or if you found a bug, please [open a support ticket](http://help.37signals.com/tickets/new). Also, feel free to fork these docs and send a pull request with improvements!

To talk with us and other developers about the API, subscribe to the [37signals-api mailing list](http://groups.google.com/group/37signals-api).
