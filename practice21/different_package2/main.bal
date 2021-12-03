// import ballerina/io;
// import json_rpc.server;

// type Nip record {|
//     int x;
//     int y;
// |};

// string str = "{\"jsonrpc\":\"2.0\",\"method\":\"add\",\"params\":{\"x\":89, \"y\":100},\"id\":10}";
// string str2 = "{\"foo\": \"boo\"}";
// string str3 = "[{\"jsonrpc\":\"2.0\",\"method\":\"add\",\"params\":{\"x\":89, \"y\":100},\"id\":10}, {\"jsonrpc\":\"2.0\",\"method\":\"sub\",\"params\":{\"x\":89, \"y\":100},\"id\":10}]";
// string str4 = "{\"jsonrpc\":\"2.0\",\"method\":\"mult\",\"params\":[10,20,30],\"id\":10}";
// string str5 = "{\"jsonrpc\":\"2.0\",\"method\":\"print\",\"id\":10}";
// string str60 = "{\"jsonrpc\":\"2.0\",\"method\":\"add\",\"params\":100,\"id\":10}";
// string str6 = "[]";
// public function main() {
//     server:Server s1 = new();
//     s1.serverFunction("add", addFunction);
//     io:println(s1.runner(str60));
// }

// public isolated function addFunction(server:Input ifs) returns int|error{
//   Nip nip = check ifs.cloneWithType();
//   return nip.x + nip.y;
// }

// public isolated function printArray(server:Input fis) {
//   any [] p = <any[]> fis;
//   io:println(p[1]);
// }

import ballerina/io;
import ballerina/log;
import ballerina/tcp;
import asus/json_rpc.server;

type Nip record {|
    int x;
    int y;
|};

service on new tcp:Listener(3000) {

    remote function onConnect(tcp:Caller caller)
                              returns tcp:ConnectionService {
        io:println("Client connected to echo server: ", caller.remotePort);
        return new EchoService();
    }
}

service class EchoService {
    *tcp:ConnectionService;
    remote function onBytes(tcp:Caller caller, readonly & byte[] data) returns tcp:Error? {
        io:println("Echo: ", string:fromBytes(data));

        //Calling the library
        server:Server s1 = new();
        s1.serverFunction("add", addFunction);
        io:println(s1.runner(checkpanic string:fromBytes(data)));

        return caller->writeBytes(s1.runner(checkpanic string:fromBytes(data)).toString().toBytes());
    }

    remote function onError(tcp:Error err) {
        log:printError("An error occurred", 'error = err);
    }

    remote function onClose() {
        io:println("Client left");
    }
}


public isolated function addFunction(server:Input ifs) returns int|error{
  Nip nip = check ifs.cloneWithType();
  return nip.x + nip.y;
}

public isolated function printArray(server:Input fis) {
  any [] p = <any[]> fis;
  io:println(p[1]);
}