import ballerina/io;
import ballerina/lang.value;

public function main() returns error? {
    io:println("Json practicing....");

    json j = {"name": "madusanka", "age": 24, "company": "WSO2"};
    string s = j.toJsonString();
    json j2 = check value:fromJsonString(s);

    string name = check j.name;

    io:println(j);
    io:println(s);
    io:println(j2);
    io:println(name);
}