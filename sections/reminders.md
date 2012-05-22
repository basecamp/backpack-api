Reminders
=========

List upcoming
-------------

* `GET /#{token}/reminders.xml` lists reminders with those to be reminded earliest first

**Response:**

``` xml
<reminders>
  <reminder id="5">
    <remind_at>2007-07-03 14:59:00</remind_at>
    <content>Hello</content>
    <creator id="123" name="John D." />
    <remindees>
      <user id="456" name="Jane D." />
    </remindees>
  </reminder>
  <reminder id="6">
    <remind_at>"2007-09-03 15:59:00"</remind_at>
    <content>World!</content>
    <creator id="456" name="Jane D." />
    <remindees>
      <user id="123" name="John D." />
      <user id="789" name="Foo B." />
    </remindees>
  </reminder>
</reminders>
```

Create with fuzzy date
----------------------

* `POST /#{token}/reminders.xml` creates a reminder with a fuzzy date in the content.

**Request:**

``` xml
<reminder>
  <content>+30 In thirty minutes!</content>
  <remindees type="array">
    <user_id>123</user_id>
    <user_id>456</user_id>
  </remindees>
</reminder>
```

**Response:**

    Status: 201 Created
    Location: /reminders/#{id}

``` xml
<reminder id="1234">...</reminder>
```

Create with specific date
-------------------------

* `POST /#{token}/reminders.xml` creates a reminder with a specific date.

**Request:**

``` xml
<reminder>
  <remind_at>2007-07-03 19:51:00</remind_at>
  <content>In thirty minutes!</content>
  <remindees type="array">
    <user_id>123</user_id>
    <user_id>456</user_id>
  </remindees>
</reminder>
```

**Response:**

    Status: 201 Created
    Location: /reminders/#{id}

``` xml
<reminder id="1234">...</reminder>
```

Update
------

* `PUT /#{token}/reminders/#{id}.xml` changes a reminder.

**Request:**

``` xml
<reminder>
  <remind_at>2007-07-03 20:06:00</remind_at>
  <content>In forty-five minutes!</content>
  <remindees type="array">
    <user_id>123</user_id>
    <user_id>456</user_id>
  </remindees>
</reminder>
```

**Response:**

    Status: 200 OK

Destroy
-------

* `DELETE /#{token}/reminders/#{id}.xml` removes a reminder.

**Response:**

    Status: 204 No Content
