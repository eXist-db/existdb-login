Developed on eXistdb 3.4.1 but should be backward compatible.

[Ready-for-use]

# existdb-login


This app serves two purposes:
 * showing a reference implementation of an eXistdb login
 * providing a login web component for use with bower
 
## Reference login implementation

Implementing a proper login for an eXistdb app isn't always as easy as it 
should be. It requires some knowledge of how the controller.xql and the
login.xql work.

In this app a barebone controller is used that shows how to setup restricted pages.
There's a public and a restricted page. The public page (index.html) can be visited
by any person without logging into the database.

The restricted page however requires that a user is in the 'dba' group. You can login by using a link on 
the unrestricted page. 

When you start a new app you can use the controller.xql as your base and add
further rules as you need to.

## 2 options for the login form

Looking at the login.html you'll find 2 variants of a login form that are essentially the same. The first one is a Web Component
and is described below. The second is a plain HTML form. If you're not intending to use Web Components the plain form is for you.

The Web Component essentially wraps a form with some nicer Material Design components, some simple error messaging and auto-send when hitting enter on the
form.

## existdb-login Web Component

The existdb-login component encapsulates a form using Material Design styles and
is implemented as a Polymer 2 component. 

When you use web components you can use pull this component into your project by using
bower like this:

```
bower install --save http://gitlab.exist-db.org/eXistdbElements/existdb-login.git
```

## How to use

existdb-login is a standalone app that you can deloy as-is to eXistdb. It shows a barebone example of how to setup
authentication for an app. 

To use it there are several approaches:
 * copy, paste and adapt the code. Your main interest will be controller.xql and probably login.html. The controller
   is documented inline and should it should be easy enough to copy the relevant parts.
 * When you use bower in your project anyay you can install the code via the above statement. This mostly gives
 you the convenience of having it right in your project for reference as well as the option to use the 
 provided existdb-login Web Component. But you'll still need to copy/adapt the login.html and merge the controller.xql rules
 into your application controller.xql. 


