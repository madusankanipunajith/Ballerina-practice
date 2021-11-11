import ballerina/io;
import ballerina/jballerina.java;
import ballerina/jballerina.java.arrays;

public function splitString(handle reciever, handle regex) returns handle = @java:Method {
    'class: "java/lang/String",
    name: "split"
}external;

public function asList(int... values) returns handle = @java:Method {
    name: "asList",
    'class: "java.util.Arrays"
} external;

public function main() returns error?{
    handle text = java:fromString("Madusanka Nipunajith");
    handle regex = java:fromString(" ");

    handle answer = splitString(text, regex);

    int length = arrays:getLength(answer);
    handle secondString = arrays:get(answer,1);
    io:println(length);
    io:println(secondString);

    handle result = asList(10,20,30,40);
    int number = arrays:getLength(result);
    io:println(number);
}