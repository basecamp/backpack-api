Notes
=====

List
----

* `POST /ws/page/#{page_id}/notes/list` lists notes ordered by age, oldest first.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
</request>
```

**Response:**

``` xml
<response success='true'>
  <notes>
    <note id='1132' title='My world!' created_at='2007-07-03 19:15:55'>
      It's a pretty place
    </note>
    <note id='1133' title='Your world!' created_at='2007-07-03 19:20:00'>
      Also pretty
    </note>
  </notes>
</response>
```

Create
------

* `POST /ws/page/#{page_id}/notes/create` adds a new note to the page.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
  <note>
    <title>My new note!</title>
    <body>I'm a new note!</body>
    <show-created-at>false</show-created-at>
  </note>
</request>
```

**Response:**

``` xml
<response success='true'>
  <note id='5' title='My new note!' created_at='2007-07-03 19:21:00'>
    I'm a new note!
  </note>
</response>
```

Update
------

* `POST /ws/page/#{page_id}/notes/update/#{id}` changes a note.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
  <note>
    <title>My updated note!</title>
    <body>I'm updated here too!</body>
    <show-created-at>true</show-created-at>
  </note>
</request>
```

**Response:**

``` xml
<response success='true' />
```

Destroy
-------

* `POST /ws/page/#{page_id}/notes/destroy/#{id}` removes a note from the page.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
</request>
```

**Response:**

``` xml
<response success='true' />
```
