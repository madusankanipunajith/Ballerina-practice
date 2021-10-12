import ballerina/http;

service /hello on new http:Listener(9090){
    resource function get sayHello() returns string {
        return "Hello... Madusanka is learning ballerina!";
    }
}



