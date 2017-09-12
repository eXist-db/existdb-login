# existdb-login

This app serves two purposes:
 * showing a reference implementation of an eXistdb login
 * providing a login web component for use with bower
 
## Reference login implementation

Implementing a proper login for an eXistdb app isn't always as easy as it 
should be. It requires some knowledge of how the controller.xql and the
login.xql work.

In this app a barebone controller is used that shows how to setup restricted pages.
There's a public and a restricuted page. The public page (index.html) can be visited
by any person without logging into the database.

The restricted page however requires that a user is in the 'dba' group. You can login by using a link on 
the unrestricted page. 

When you start a new app you can use the controller.xql as your base and add
further rules as you need to.

## existdb-login Web Component

The existdb-login component encapsulates a form using Material Design styles and
is implemented as a Polymer 2 component. 

When you use web components you can use pull this component into your project by using
bower like this:

```
bower install --save http://gitlab.exist-db.org/eXistdbElements/existdb-login.git
```


