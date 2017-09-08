xquery version "3.1";

import module namespace login="http://exist-db.org/xquery/login" at "resource:org/exist/xquery/modules/persistentlogin/login.xql";
import module namespace console="http://exist-db.org/xquery/console";

declare variable $exist:path external;
declare variable $exist:resource external;
declare variable $exist:controller external;
declare variable $exist:prefix external;
declare variable $exist:root external;
(:declare variable $exist:user external;:)

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
        login:set-user("org.exist.login", (), true()),
        let $userParam := request:get-parameter("user","")
        let $user := request:get-attribute("org.exist.login.user")
        let $out := request:get-parameter("logout",())
        let $log := util:log("info","user: <" || data($user) || ">")
        let $log := util:log("info","userParam: <" || $userParam || ">")
        let $result := if (not($userParam != data($user))) then "true" else "false"
        let $log := util:log("info", $result)

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
            (:
                if a user was send as request param
                and it is NOT the same as the $user
                a former login attempt has failed.
            :)
            else if(not(string($userParam) eq string($user))) then
                <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                    <forward url="fail.html"/>
                </dispatch>
            else
                <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                    <forward url="login.html"/>
                </dispatch>
    )else ()