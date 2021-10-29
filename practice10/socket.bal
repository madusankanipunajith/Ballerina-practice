import ballerina/http;

service /ballerina on new http:Listener(8080) {
    resource function get name/[string name]() returns string{
        return string `${name} is my name`;
    }
}

// create a socket
