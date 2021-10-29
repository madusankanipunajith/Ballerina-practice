import ballerina/io;
import ballerina/tcp;
import ballerina/log;

service on new tcp:Listener(3000){
    
    // remote functions are triggered dynamically... we dont need to call it 
    // here caller is acting as client socket and it returns a tcp:connection service as an output 

    remote function onConnect(tcp:Caller caller) returns tcp:ConnectionService | tcp:Error?{
        io:println("Client connected to the server : ", caller.remotePort);
        return new echoService();
    }
}

service class echoService {

    remote function onBytes(tcp:Caller caller, readonly & byte[] data) returns tcp:Error?{
        io:println("My name is : ", string:fromBytes(data));
        check caller->writeBytes(data); 
    }

    remote function onError(tcp:Error err) returns tcp:Error? {
        log:printError("An error occurred", 'error = err);
    }

    remote function onClose() returns tcp:Error? {
        io:println("Client left");
    }
    
}




