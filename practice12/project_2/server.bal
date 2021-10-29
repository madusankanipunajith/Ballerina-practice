import ballerina/io;
import ballerina/tcp;
import ballerina/log;

type JsonRecord record {
    string jsonrpc;
    string method;
    string id;
    int[] params;
};

service on new tcp:Listener(8080) {
    
    remote function onConnect(tcp:Caller caller) returns tcp:ConnectionService | tcp:Error?{
        io:println("client is connected succesfully on port : ", caller.remotePort);
        return new echoService();
    }
}

service class echoService {
    
    remote function onBytes(tcp:Caller caller, readonly & byte[] data) returns tcp:Error?{
        
        string|error stringJsonMsg = string:fromBytes(data);

        io:StringReader sr = new(checkpanic stringJsonMsg, encoding = "UTF-8");
        json jsonMsg = checkpanic sr.readJson();
       
        JsonRecord|error jr =  jsonMsg.cloneWithType();

        if jr is error {
            io:println("something went wrong...");
        }else{
            io:println("version is always 2.0");
            io:println("method : ", jr.method);
            io:println("params : ", jr.params);
            io:println("id : ", jr.id);
        }
    }

    remote function onError(tcp:Error err) returns tcp:Error?{
        log:printError("An error occurred",'error = err);
    }
    remote function onClose() returns tcp:Error?{
        io:println("Client connection is closed");
    }
}