// import json_rpc.server;
// import json_rpc.'type;
// import ballerina/io;

// string str = "{\"jsonrpc\":\"2.0\",\"method\":\"add\",\"params\":{\"x\":89, \"y\":100},\"id\":10}";
// string str2 = "{\"foo\": \"boo\"}";
// string str3 = "[{\"jsonrpc\":\"2.0\",\"method\":\"add\",\"params\":{\"x\":89, \"y\":100},\"id\":10}, {\"jsonrpc\":\"2.0\",\"method\":\"sub\",\"params\":{\"x\":89, \"y\":100},\"id\":10}]";
// string str4 = "{\"jsonrpc\":\"2.0\",\"method\":\"mult\",\"params\":[10,20,30],\"id\":10}";
// string str5 = "{\"jsonrpc\":\"2.0\",\"method\":\"print\",\"id\":10}";
// string str60 = "{\"jsonrpc\":\"2.0\",\"method\":\"add\",\"params\":100,\"id\":10}";
// string str6 = "[]";

// type Nip record {|
//     int x;
//     int y;
// |};

// public function main() {

//     Calculator calc = new(ms);
//     server:Server s1 = new(calc);
//     io:println(s1.runner(str3));

// }

// class Calculator{
//   *server:JRPCService;

//     function init('type:Methods methods) {
//       self.methods = methods;
//     }   

//     public isolated function name() returns string|error {
//         return "calculator";
//     }

// }

// public isolated function addFunction(server:Input ifs) returns int|error{
//   Nip nip = check ifs.cloneWithType();
//   return nip.x + nip.y;
// }

// 'type:Methods ms ={
//   "add": addFunction
// };

import ballerina/io;
import ballerina/tcp;
public function main() returns error? {
    tcp:Client socketClient = check new ("localhost", 3000);

    string msg = "Hello Ballerina Echo from client";
    byte[] msgByteArray = msg.toBytes();
    check socketClient->writeBytes(msgByteArray);

    readonly & byte[] receivedData = check socketClient->readBytes();
    readonly & byte[] receivedData2 = check socketClient->readBytes();
    io:println("Received: ", string:fromBytes(receivedData));
    io:println("Received: ", string:fromBytes(receivedData2));

    return socketClient->close();
}
  
