Status
======

List
----

* `GET /statuses.xml` lists all statuses in your account. Users who have not posted a status will not be included.

**Response:**

``` xml
<statuses type="array">
  <status>
    <id type="integer">...</id>
    <message>...</message>
    <updated-at type="datetime">...</updated-at>
    <user-id type="integer">...</user-id>
    <user>
      <id type="integer">...</id>
      <name>...</name>
    </user>
  </status>
  ...
</statuses>
```

Show
----

* `GET /users/#{user_id}/status.xml` retrieves the status for a specific user.

If the user has never set their status, this will return a `404 Not Found` response.

**Response:**

``` xml
<status>
  <id type="integer">...</id>
  <message>...</message>
  <updated-at type="datetime">...</updated-at>
  <user-id type="integer">...</user-id>
</status>
```

Update
------

* `PUT /users/#{user_id}/status.xml` update the status for the given `user-id`.

You may only update your own status; attempting to update someone else's status will result in a `403 Forbidden` response.

**Request:**

``` xml
<status>
  <message>...</message>
</status>
```

**Response:**

    Status: 200 OK
