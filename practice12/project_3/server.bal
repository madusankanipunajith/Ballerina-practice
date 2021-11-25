import ballerina/io;
import ballerina/tcp;
import ballerina/log;


service on new tcp:Listener(8080) {
    
    remote function onConnect(tcp:Caller caller) returns tcp:ConnectionService | tcp:Error?{
        io:println("client is connected succesfully on port : ", caller.remotePort);
        return new echoService();
    }
}

service class echoService {
    *tcp:ConnectionService;
    remote function onBytes(tcp:Caller caller, readonly & byte[] data) returns tcp:Error?{
        
        string|error stringJsonMsg = string:fromBytes(data);

        io:StringReader sr = new(checkpanic stringJsonMsg, encoding = "UTF-8");
        json jsonMsg = checkpanic sr.readJson();
        io:println(jsonMsg);
        
    }

    remote function onError(tcp:Error err) returns tcp:Error?{
        log:printError("An error occurred",'error = err);
    }
    remote function onClose() returns tcp:Error?{
        io:println("Client connection is closed");
    }
}