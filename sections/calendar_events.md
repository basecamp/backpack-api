Calendar Events
===============

List
----

* `GET /calendars/#{calendar_id}/calendar_events.xml` returns all events for the given calendar.

**Response:**

``` xml
<calendar-events>
  <calendar-event>
    <calendar-id type="integer">5</calendar-id>
    <id type="integer">21</id>
    <title>Dinner with Jamis</title>
    <remind type="boolean">false</remind>
    <occurs-at type="datetime">2006-10-06T00:00</occurs-at>
    ...
  </calendar-event>
</calendar-events>
```

Show
----

* `GET /calendar_events/#{event_id}.xml` returns information about the referenced event.

**Response:**

``` xml
<calendar-event>
  <calendar-id type="integer">5</calendar-id>
  <id type="integer">21</id>
  <title>Dinner with Jamis</title>
  <remind type="boolean">false</remind>
  <occurs-at type="datetime">2006-10-06T00:00</occurs-at>
  ...
</calendar-event>
```

Create
------

* `POST /calendar_events.xml` creates a new event.

Required fields are the `title` for the event as well as the `calendar_id` of the calendar you would like the event to be added to.

**Request:**

``` xml
<request>
  <event>
    <calendar-id>#{calendar_id}</calendar-id>
    <title>9/27 Dinner with mom</title>
    <!-- optional -->
    <remind>1</remind>
  </event>
</request>
```

**Response:**

    Status: 201 Created
    Location #{url of newly created calendar event}

Delete
------

* `DELETE /calendar_events/#{event_id}.xml` deletes an existing event identified by its integer ID.

**Response:**

  Status: 200 OK

Update
------

* `PUT /calendar_events/#{event_id}.xml` updates an existing event identified by its integer ID.

**Request:**

``` xml
<request>
  <event>
    <title>9/28 Dinner with mom</title>
    <!-- optional -->
    <remind>1</remind>
  </event>
</request>
```

**Response:**

    Status: 200 OK
