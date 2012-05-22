Journal
=======

*Note*: You may only [Show](#show), [Create](#create), [Update](#update), or [Delete](#delete) your own journal entries. Attempting to do these actions on someone else's journal entries will result in a `403 Forbidden` response.

List
----

* `GET /journal_entries.xml?n=0&count=100` lists journal entries aggregated across all users in the account.
* `GET /users/#{user_id}/journal_entries.xml?n=0&count=100` lists journal entries for a specific user.

By default, only the first 100 entries will be returned, but you can specify a smaller window size via the `count` query parameter, and you can select a different page of entries via the `n` query parameter. Both `count` and `n` are optional; `count` defaults to 100 (which is also the maximum size), and `n` defaults to 0 (the first page).

**Response:**

``` xml
<journal-entries type="array">
  <journal-entry>
    <body>...</body>
    <created-at type="datetime">...</created-at>
    <id type="integer">...</id>
    <updated-at type="datetime">...</updated-at>
    <user>
      <id type="integer">...</id>
      <name>...</name>
    </user>
  </journal-entry>
  ...
</journal-entries>
```

Show
----

* `GET /journal_entries/#{id}.xml` retrieves a specific journal entry by ID.

**Response:**

``` xml
<journal-entry>
  <account-id type="integer">...</account-id>
  <body>...</body>
  <created-at type="datetime">...</created-at>
  <id type="integer">...</id>
  <updated-at type="datetime">...</updated-at>
  <user-id type="integer">...</user-id>
</journal-entry>
```

Create
------

* `POST /users/#{user_id}/journal_entries.xml` creates a new journal entry for the given user.

**Request:**

``` xml
<journal-entry>
  <body>...</body>
</journal-entry>
```

**Response:**

    Status: 201 Created
    Location: http://.../journal-entries/#{id}

Update
------

* `PUT /journal_entries/#{id}.xml` updates the contents of an existing journal entry.

**Request:**

``` xml
<journal-entry>
  <body>...</body>
</journal-entry>
```

**Response:**

``` xml
<journal-entry>
  <account-id type="integer">...</account-id>
  <body>...</body>
  <created-at type="datetime">...</created-at>
  <id type="integer">...</id>
  <updated-at type="datetime">...</updated-at>
  <user-id type="integer">...</user-id>
</journal-entry>
```

Delete
------

* `DELETE /journal_entries/#{id}.xml` deletes a single journal entry.

**Response:**

    Status: 200 OK
