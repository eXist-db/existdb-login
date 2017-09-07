xquery version "3.1";

import module namespace login="http://exist-db.org/xquery/login" at "resource:org/exist/xquery/modules/persistentlogin/login.xql";
import module namespace console="http://exist-db.org/xquery/console";

declare variable $exist:path external;
declare variable $exist:resource external;
declare variable $exist:controller external;
declare variable $exist:prefix external;
declare variable $exist:root external;
declare variable $exist:user external;

console:log("controller path: " || $exist:path),
if ($exist:path eq '') then
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="{request:get-uri()}/"/>
    </dispatch>
else if ($exist:path = "/") then(
    console:log("matched '/'" || $exist:path),
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="index.html"/>
    </dispatch>
)

(: auth:isPathAllowed([path],[group]) :)
else if (ends-with($exist:path, "index.html")) then (
        login:set-user("org.exist.login", (), false()),
        let $log := console:log("index.html matched")
        let $user := request:get-attribute("org.exist.login.user")
        let $out := request:get-parameter("logout",())
        let $log := console:log("user: " || $user)
        return
            if($out = "true") then(
                console:log("logout: dispatch"),
                <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                    <redirect url="index.html"/>
                </dispatch>
            )
            else if ($user and sm:is-dba($user)) then
                <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                    <cache-control cache="no"/>
                </dispatch>
            else
                <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                    <forward url="login.html"/>
                </dispatch>
    )else ()