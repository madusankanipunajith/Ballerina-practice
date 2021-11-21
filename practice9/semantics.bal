import ballerina/io;

public function main() returns error?{
    io:println("studing semantics....");

    do {
        
        check foo();
        check bar();

        if !isOK() {
            fail error("error is occured...");
        }

    }on fail var e {
        io:println(e.toString());
        return e;
    }
}

function foo() returns error? {
    io:println("OK");
}
function bar() returns error? {
    io:println("OK");
}
function isOK() returns boolean {
    return false;

}