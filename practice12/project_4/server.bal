import ballerina/tcp;
import ballerina/io;
import ballerina/log;

type JsonRecord record {
    string id?;
    string method;
    string jsonrpc;
    int[] params;
};

service on new tcp:Listener(8080) {
    
    remote function onConnect(tcp:Caller caller) returns tcp:ConnectionService | tcp:Error?{
        io:println("client is connect to the server socket with port : ", caller.remotePort);
        
        return new echoServer();
    }
}

service class echoServer {
    remote function onBytes(tcp:Caller caller , readonly & byte[] data) returns tcp:Error?{
        
        string|error stringJsonMsg = string:fromBytes(data);

        io:StringReader sr = new(checkpanic stringJsonMsg, encoding = "UTF-8");
        json jsonMsg = checkpanic sr.readJson();
        
        //io:println(jsonMsg);
        JsonRecord|error jr =  jsonMsg.cloneWithType();

        if jr is error {
            io:println("something went wrong...");
        }else{
            io:println("version is always 2.0");
            io:println("method : ", jr.method);
            io:println("params : ", jr.params);
            io:println("id : ", jr?.id);

            string? id = jr?.id;

            float|error? output = arithmaticEvaluation(jr);
            float|string result = 0.0f;

            if output is float{
                result = output;
            }else{
                result = "invalid method";
            }

            if id !== () {
                io:println("Id is there : ", result);
                json response ={
                    id: id,
                    jsonpc: "2.0",
                    result: result.toString()
                };
                byte[] responseByteArray = response.toJsonString().toBytes();
                check caller->writeBytes(responseByteArray);
            }
        }
    }

    remote function onError(tcp:Error err) {
        log:printError("Error is occured", 'error = err);
    }

    remote function onClose() returns tcp:Error?{
        io:println("client is disconnected");
    }

}

function arithmaticEvaluation(JsonRecord msg) returns float|error? {
    string method = msg.method;
    int[] numberArray = msg.params;
    
    float answer = 0.0f;

    match method {
        "add" => {
            foreach int number in numberArray {
                answer = answer+ <float>number;
            }
        }
        "sub" =>{
            foreach int number in numberArray {
                answer -= <float>number;
            }
        }
        "div" =>{
            answer = <float>(numberArray[0]/numberArray[1]);
        }
        "mult" =>{
            answer = answer + 1.0f;
            foreach int number in numberArray {
                answer *= <float>number;
            }
        }
        _ =>{
            return error("Invalid method...");
        }
    }

    return answer;
}