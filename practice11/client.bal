import ballerina/io;
import ballerina/websocket;

public function main() returns error?{

   string username = io:readln("Enter your name :");

   websocket:Client webClient = check new(string `ws://localhost:9090/subscribe/${username}`);
   
   check webClient->writeTextMessage(username);

   io:println("message is sent to the server socket");

    while true {
        string textResp = check webClient->readTextMessage();
        io:println(textResp);
    }
}


