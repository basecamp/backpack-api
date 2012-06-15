Separators
==========

Create
------

* `POST /pages/#{page_id}/separators.xml` adds a new separator to the page.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
  <separator>
    <name>Photos</name>
  </separator>
</request>
```

**Response:**

    Status: 201 Created
    Location: /pages/1/separators/5.xml

``` xml
<separator>
  <id type="integer">1</id>
  <name>Photos</name>
  <page-id type="integer">5</page-id>
</separator>
```

Update
------

* `PUT /pages/#{page_id}/separators/#{id}.xml` changes a separator.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
  <separator>
    <name>New photos</name>
  </separator>
</request>
```

**Response:**

    Status: 200 OK

Destroy
-------

* `DELETE /pages/#{page_id}/separators/#{id}.xml` removes a separator from the page.

Alternatively:

* `POST /ws/page/#{page_id}/separators/destroy/#{id}`

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
</request>
```

**Response:**

    Status: 204 No Content
