Bookmarks
=========

List
----

* `GET /#{token}/users/#{user_id}/bookmarks.xml` lists all of a user's bookmarks (links to pages and tags in the sidebar).

Only the current user's bookmarks can be viewed.

**Response:**

``` xml
<bookmarks type="array">
  <bookmark>
    <id type="integer">1</id>
    <user-id type="integer">2</user-id>
    <bookmarkable-type type="string">Page</bookmarkable-type>
    <bookmarkable-id type="integer">3</page-id>
    <position type="integer">1</position>
    ...
  </bookmark>
  <bookmark>
    <id type="integer">2</id>
    <user-id type="integer">2</user-id>
    <bookmarkable-type type="string">Tag</bookmarkable-type>
    <bookmarkable-id type="integer">4</page-id>
    <position type="integer">2</position>
    ...
  </bookmark>
  ...
</bookmarks>
```
