Users
=====

For all User endpoints, omit the leading `/#{token}` from the URL if you're using OAuth instead of API tokens.

Current user
------------

* `GET /#{token}/me.xml` retrieve information about the user you're logged in as.

This can be handy for finding out the user's `user_id` from their login token, or for discovering the user's start page.

**Response:**

``` xml
<user>
  <account-id type="integer">89</account-id>
  <created-at type="datetime">2000-01-01T00:00:00Z</created-at>
  <id type="integer">1234</id>
  <identity-url nil="true"/>
  <mobile-phone-host nil="true"/>
  <mobile-phone-number nil="true"/>
  <remind-via-email type="boolean">true</remind-via-email>
  <remind-via-mobile type="boolean">false</remind-via-mobile>
  <reminder-address>johndoe@somedomain</reminder-address>
  <start-page-id type="integer">2345</start-page-id>
  <time-zone-id>Pacific Time (US &amp; Canada)</time-zone-id>
  <updated-at type="datetime">2000-03-01T00:00:00Z</updated-at>
  <use-24h-clock type="boolean">false</use-24h-clock>
  <name>John Doe</name>
  <email-address>johndoe@somedomain</email-address>
  <admin type="boolean">true</admin>
</user>
```

List
----

* `GET /#{token}/users.xml` list the users on this account.

**Response:**

``` xml
<users type="array">
  <user>
    <id type="integer">1234</id>
    <name>John Doe</name>
  </user>
  <user>
    <id type="integer">5678</id>
    <name>Foo Bar</name>
  </user>
</user>
```

Export
------

* `GET /#{token}/users/#{id}/export.xml` export users accessible pages and reminders.

**Response:**

``` xml
<user id="1" name="John Doe" account="mybackpack">
  <pages>
    <page>...</page>
  </pages>
  <reminders>
    <reminder>...</reminder>
  </reminders>
</user>
```
