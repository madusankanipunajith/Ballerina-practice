import ballerina/io;
import json_rpc.server;

type Nip record {|
    int x;
    int y;
|};

type Sip record {|
    int[] arr;
|};

// json rpc messages come from client
string str = "{\"jsonrpc\":\"2.0\",\"method\":\"add\",\"params\":{\"x\":89, \"y\":100},\"id\":10}";
string str2 = "{\"foo\": \"boo\"}";
string str3 = "[{\"jsonrpc\":\"2.0\",\"method\":\"add\",\"params\":{\"x\":89, \"y\":100},\"id\":10}, {\"jsonrpc\":\"2.0\",\"method\":\"sub\",\"params\":{\"x\":89, \"y\":100},\"id\":10}]";
string str4 = "{\"jsonrpc\":\"2.0\",\"method\":\"mult\",\"params\":[10,20,30],\"id\":10}";
string str5 = "{\"jsonrpc\":\"2.0\",\"method\":\"print\",\"id\":10}";
string str60 = "{\"jsonrpc\":\"2.0\",\"method\":\"add\",\"params\":100,\"id\":10}";

public function main() {

    io:println("hello");
    server:Server s1 = new();
    server:Server s2 = new();
    s1.serverFunction("add", addFunction);
    s1.serverFunction("sub", subFunction);
    s2.serverFunction("add", addFunction);

    // io:println(madusanka.messageCatcher(str));
    io:println(s2.messageCatcher(str60));
    
}


public function addFunction(server:InputFunc ifs) returns int|error{
  json nips = <json> ifs;
  Nip nip = check nips.cloneWithType();
  return nip.x + nip.y;
}

public function subFunction(server:InputFunc ifs) returns int|error{
  json nips = <json> ifs;
  Nip nip = check nips.cloneWithType();
  return nip.x - nip.y;
}

public function printFunction(server:InputFunc ifs){
 io:println("This is a function without parameters request");
}



