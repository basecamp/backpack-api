Pages
=====

List all
--------

* `POST /ws/pages/all` lists the pages in your account.

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
    <page scope='personal' title='Example page' id='1134' />
    <page scope='personal' title='Movie Titles' id='1136' />
    <page scope='friends' title='Ajax Summit' id='1133' />
  </pages>
</response>
```

Search
------

* `POST /ws/pages/search` searches the pages in your account.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
  <term>needle</term>
</request>
```

**Response:**

``` xml
<response success='true'>
  <pages>
    <page title='Haystack' id='1134' />
    <page title='Sewing' id='2482' />
  </pages>
</response>
```

Create
------

* `POST /ws/pages/new` creates a new page.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
  <page><title>My new page!</title></page>
</request>
```

**Response:**

``` xml
<response success='true'>
  <page title='My new page!' id='1234' />
</response>
```

Show
----

* `POST /ws/page/#{id}` returns a single page.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
</request>
```

**Response:**

``` xml
<response success='true'>
  <page title='Ajax Summit' id='1133' email_address='ry87ib@backpackit.com'>
    <belongings>
      <belonging id='783'>
        <position>1</position>
        <widget type='Note' id='1019' />
      </belonging>
      <belonging id='784'>
        <position>2</position>
        <widget type='Note' id='1020' />
      </belonging>
      <belonging id='785'>
        <position>3</position>
        <widget type='List' id='937' />
      </belonging>
    </belongings>
    <notes>
      <note title='' id='1019' created_at='2005-05-14 16:39:02'>
        With O'Reilly and Adaptive Path
      </note>
      <note title='Hotel' id='1020' created_at='2005-05-14 16:41:11'>
        Staying at the Savoy
      </note>
    </notes>
    <lists>
      <list id='937' name='Trip to SF'>
        <items>
          <item id='3308' completed="false">See San Francisco</item>
          <item id='3303' completed="true">Meet interesting people</item>
          <item id='3307' completed="true">Present Backpack</item>
        </items>
      </list>
    </lists>
    <tags>
      <tag name='Technology' id='4' />
      <tag name='Travel' id='5' />
    </tags>
  </page>
</response>
```

Reorder
-------

* `POST /ws/page/#{id}/reorder` reorders the items on the page.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
  <belongings>785 783 784</belongings>
</request>
```

**Response:**

``` xml
<response success='true' />
```

Destroy
-------

* `POST /ws/page/#{id}/destroy` destroys a page.

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

Update title
------------

* `POST /ws/page/#{id}/update_title` changes the page title.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
  <page><title>I'm a new title!</title></page>
</request>
```

**Response:**

``` xml
<response success='true' />
```

Duplicate
---------

* `POST /ws/page/#{id}/duplicate` copies a page.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
</request>
```

**Response:**

``` xml
<response success='true'>
  <page title='My new page! (copy)' id='1235' />
</response>
```

Share
-----

* `POST /ws/page/#{id}/share` shares a page with friends or make it public.

Both `email_addresses` and `public` parameters are optional. You can do both at the same time or just one at a time. Public is `1 = true`, `0 = false`.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
  <email_addresses>
    first_friend@example.com second@example.com
    another@example.com
  </email_addresses>
  <page>
    <public>1</public>
  </page>
</request>
```

**Response:**

``` xml
<response success='true' />
```

Unshare a friend's page
-----------------------

* `POST /ws/page/#{id}/unshare_friend_page` removes a page a friend shared with you.

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

Email a copy to yourself
------------------------

* `POST /ws/page/#{id}/email` emails a text version of a page to yourself.

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
