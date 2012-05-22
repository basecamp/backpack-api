Lists
=====

List
----

* `POST /ws/page/#{page_id}/lists/list` gets the lists on a page.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
</request>
```

**Response:**

``` xml
<response success='true'>
  <lists>
    <list id='1' name='greetings' />
    <list id='2' name='goodbyes' />
  </lists>
</response>
```

Create
------

* `POST /ws/page/#{page_id}/lists/add` adds a new list to the page.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
  <name>parts</name>
</request>
```

**Response:**

``` xml
<response success='true'>
  <list id='3' name='parts'/>
</response>
```

Update
------

* `POST /ws/page/#{page_id}/lists/update/#{id}` changes a list's name.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
  <list><name>ingredients</name></list>
</request>
```

**Response:**

``` xml
<response success='true' />
```

Destroy
-------

* `POST /ws/page/#{page_id}/lists/destroy/#{id}` removes a list and its items from the page.

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
