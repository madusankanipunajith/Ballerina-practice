import ballerina/io;
import ballerina/websocket;


listener websocket:Listener serverListener = new websocket:Listener(9090);


service /subscribe on serverListener{
 
    resource isolated  function get [string name]() returns websocket:Service|websocket:UpgradeError{
        
        io:println(name);

        return service object websocket:Service {

            remote isolated  function onTextMessage(websocket:Caller caller, string data) returns websocket:Error? {
                string welcomeMsg = "Hi " + data + "! You have successfully connected.";
                io:println(welcomeMsg);
                check caller->writeTextMessage(welcomeMsg);
            }
           
        };
    }


}