List Items
==========

List
----

* `POST /ws/page/#{page_id}/lists/#{list_id}/items/list` gets items ordered by completeness and position.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
</request>
```

**Response:**

``` xml
<response success='true'>
  <items>
    <item id='1' list_id='1' completed='false' updated_at='2011-03-26 19:15:55'>Hello world!</item>
    <item id='2' list_id='1' completed='false' updated_at='2011-01-15 16:25:37'>More world!</item>
    <item id='3' list_id='1' completed='true' updated_at='2011-01-15 16:26:13'>Done world!</item>
  </items>
</response>
```

Create
------

* `POST /ws/page/#{page_id}/lists/#{list_id}/items/add` adds a new item to a list.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
  <item completed='true'><content>I'm a new, completed item!</content></item>
</request>
```

**Response:**

``` xml
<response success='true'>
  <item id='5' list_id='1' completed='true'>I'm a new, completed item!</item>
</response>
```

Update
------

* `POST /ws/page/#{page_id}/lists/#{list_id}/items/update/#{id}` changes a list item.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
  <item completed='true'><content>I'm an updated item! My content will be changed and I will be marked completed.</content></item>
</request>
```

**Response:**

``` xml
<response success='true' />
```

Toggle
------

* `POST /ws/page/#{page_id}/lists/#{list_id}/items/toggle/#{id}` toggles the item from complete to incomplete or back.

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

Destroy
-------

* `POST /ws/page/#{page_id}/lists/#{list_id}/items/destroy/#{id}` removes an item from the list.

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

Move
----

* `POST /ws/page/#{page_id}/lists/#{list_id}/items/move/#{id}` moves an item lower or higher in a list or to the top or bottom.

The direction parameters are `move_lower`, `move_higher`, `move_to_bottom`, and `move_to_top`.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
  <direction>move_higher</direction>
</request>
```

**Response:**

``` xml
<response success='true' />
```

Reorder
-------

* `POST /ws/page/#{page_id}/lists/#{list_id}/items/reorder` explicitly reorders the items in a list when passed list of item ids in the desired order.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
  <item-id>item1-id</item-id>
  <item-id>item2-id</item-id>
  <item-id>...</item-id>
</request>
```

**Response:**

``` xml
<response success='true' />
```
