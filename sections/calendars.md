Calendars
=========

List all
--------

* `GET /calendars.xml` returns all calendars for the specified account.

The `token` field is for calendar sharing in urls of the form: `webcal://your-account.backpackit.com/#{token}.ics`.

**Response:**

``` xml
<calendars>
  <calendar>
    <account-id type="integer">11</account-id>
    <color>000099</color>
    <created-at type="datetime">#{created_at}</created-at>
    <ical-subscription-url></ical-subscription-url>
    <id type="integer">5</id>
    <name>Personal</name>
    <token>520</token>
    <updated-at type="datetime">#{updated_at}</updated-at>
  </calendar>
</calendars>
```
