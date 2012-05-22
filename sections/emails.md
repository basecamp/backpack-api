Emails
======

List
----

* `POST /ws/page/#{page_id}/emails/list` lists all emails for a page.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
</request>
```

**Response:**

``` xml
<response success='true'>
  <emails>
    <email id='5' title='My Subject' created_at='2007-07-03 19:15:55'>
      My body!
    </email>
    <email id='6' title='Diff Subject' created_at='2007-08-03 20:20:55'>
      My other body!
    </email>
  </emails>
</response>
```

Show
----

* `POST /ws/page/#{page_id}/emails/show/#{id}` shows a specific email.

**Request:**

``` xml
<request>
  <token>202cb962ac59075b964b07152d234b70</token>
</request>
```

**Response:**

``` xml
<response success='true'>
  <email id='5' title='My Subject' created_at='2007-07-03 19:15:55'>
    My body!
  </email>
</response>
```

Destroy
-------

* `POST /ws/page/#{page_id}/emails/destroy/#{id}` removes an email from the page.

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
