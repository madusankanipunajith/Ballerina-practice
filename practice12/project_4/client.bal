import ballerina/io;
import ballerina/tcp;

public function main() returns error?{
    io:println("Welcome to the client dashboard...");

    json msg ={"jsonrpc": "2.0", "method": "adds", "params": [1,2,4], "id":"1"};

    tcp:Client clientSocket = check new("localhost", 8080);
    
    // convirted json message into string
    string conMsg = msg.toJsonString();

    // convirted string into byte array
    byte[] msgByteArray = conMsg.toBytes(); 
    
   // send byte message to the connected server socket
   any? s = check clientSocket->writeBytes(msgByteArray);

   io:println("message is sent to the server socket");

    // response message is comming from server socket
   readonly & byte[] receivedData =  check clientSocket->readBytes();
    io:println("Received: ", string:fromBytes(receivedData));

   check clientSocket->close(); 

}