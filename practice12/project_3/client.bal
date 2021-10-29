import ballerina/io;
import ballerina/tcp;

public function main() returns error?{
    io:println("Welcome to the client dashboard...");

    json msg = {
        name: "madusanka",
        age: 24,
        company: "WSO2"
    };

    tcp:Client clientSocket = check new("localhost", 8080);
    
    // convirted json message into string
    string conMsg = msg.toJsonString();

    // convirted string into byte array
    byte[] msgByteArray = conMsg.toBytes(); 
    
   // send byte message to the connected server socket
   any? s = check clientSocket->writeBytes(msgByteArray);

   io:println("message is sent to the server socket");

   check clientSocket->close(); 

}