import ballerina/io;
import madusanka.method_handler;

type func function(int c) returns int; 

public function main() {
    
    io:println(method_handler:getX());

    method_handler:method method_1 = new("add", addFunction, 20);
    io:println(typeof method_1.getFunction());

    func z = <func> method_1.getFunction();
    io:println(z(10));
    io:println(method_1.getResult());
}

public function addFunction(int x) returns int{
    return x + 10;
}
