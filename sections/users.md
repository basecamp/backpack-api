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
  <id type="integer">1234</id>
  <name>John Doe</name>
  <start-page-id>2345</start-page-id>
  ...
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
