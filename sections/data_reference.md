Data Reference
==============

The following sections describe the different data types used by the Backpack API.

Email
-----

``` xml
<email id='5' title='My Subject' created_at='2007-07-03 19:15:55'>
  My body!
</email>
```

List item
---------

``` xml
<item id='1' list_id='1' completed='false'>Hello world!</item>
```

Note
----

``` xml
<note id='1133' title='Your world!' created_at='2007-07-03 19:20:00'>
  Also pretty
</note>
```

Page
----

``` xml
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
    <belonging id='786'>
      <position>4</position>
      <widget type='Gallery' id='2873' />
    </belonging>
    <belonging id='787'>
      <position>5</position>
      <widget type='Asset' id='60887' />
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
        <item id='3308' completed='false'>See San Francisco</item>
        <item id='3303' completed='true'>Meet interesting people</item>
        <item id='3307' completed='true'>Present Backpack</item>
      </items>
    </list>
  </lists>
  <galleries>
    <gallery id='2873' name='Around the town'>
      <images>
        <image id='88278' file_name='parrots.jpg' gallery_id='2873' description='Wild parrots of Telegraph Hill' />
      </images>
    </gallery>
  </galleries>
  <attachments>
    <attachment id='60887' file_name='itinerary.pdf' />
  </attachments>
  <tags>
    <tag name='Technology' id='4' />
    <tag name='Travel' id='5' />
  </tags>
</page>
```

Reminder
--------

``` xml
<reminder id="6">
  <remind_at>"2007-09-03 15:59:00"</remind_at>
  <content>World!</content>
  <creator id="456" name="Jane D." />
  <remindees>
    <user id="123" name="John D." />
    <user id="789" name="Foo B." />
  </remindees>
</reminder>
```

User
----

``` xml
<user id="1234" name="John Doe" account="mybackpack">
  <pages>
    <page>...</page>
  </pages>
  <reminders>
    <reminder>...</reminder>
  </reminders>
</user>
```
