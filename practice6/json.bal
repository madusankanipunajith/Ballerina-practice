import ballerina/io;
import ballerina/lang.value;

public function main() returns error? {
    io:println("Json practicing....");

    json j = {"name": "madusanka", "age": 24, "company": "WSO2"};
    string s = j.toJsonString();
    json j2 = check value:fromJsonString(s);
    json j3 = s.toJson();

    string name = check j2.name;

    io:println(j);
    io:println(s);
    io:println(j2);
    io:println(name);

    json job = {
        command: "add10",
        amount : 50
    };

    io:println(job);

    error? jsonMatchResult = jsonMatch(job);
    if jsonMatchResult is error{
        io:println(jsonMatchResult);
    }
}


function jsonMatch(json j) returns error?{
    match j {
        {command: "add10", amount: var x} => {decimal n = check <decimal|error> x; add(n+10);}
        {command: "sub10", amount: var x} => {decimal n = check <decimal|error> x; add(n-10);}
        _ => {return error("Invalid command....");}
    }
}

function add(decimal val) {
    io:println(val);
}