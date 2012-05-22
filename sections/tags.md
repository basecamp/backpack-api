Tags
====

Page matches
------------

* `POST /ws/tags/select/#{id}` lists tagged pages.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
</request>
```

**Response:**

``` xml
<response success='true'>
  <pages>
    <page id='1234' title='Backpack API' />
  </pages>
</response>
```

Tag a page
----------

* `POST /ws/page/#{page_id}/tags/tag` tags a page, overwriting any existing tags.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
  <tags>Music "Long Scores" Jazz</tags>
</request>
```

**Response:**

``` xml
<response success='true' />
```
