import json_rpc.validator;
import ballerina/io;
import ballerina/lang.value;

public type InputFunc record {|
    
    anydata...;

|};

public isolated function caller(string message, map<isolated function (InputFunc func) returns any|error> methMapper) returns validator:JsonRPCTypes?|error{
    
    validator:JsonRPCTypes|error result = trap validator:messageValidator(message);

    if result is error{
        validator:Error err ={
            id: null,
            err: {"code": "-32700", "message": "Parse error"},
            jsonrpc: "2.0" 
        };

        return err;
    
    }else {

        if result is validator:Request{

            if(methMapper[result.method] is null){
                
                // method is not found
                validator:Error err ={
                    id: result.id,
                    err: {code: "-32601", message: "method is not found"},
                    jsonrpc: "2.0"
                };

                return err;
            
            }else{

                isolated function (InputFunc) returns any|error get = methMapper.get(result.method);
                anydata params = result.params;
                
                InputFunc param;
                io:println(typeof params);

                if params === () {

                    json madu ={
                        data: null
                    };

                    param = check madu.cloneWithType();
                    any _ = check get(param);
                    return; 
                }

                if( !(params is anydata[]) && !(params is map<anydata>)){
                    
                    validator:Error err={
                        id: result.id,
                        err: {code: "-32602", message: "Invalid method parameters"},
                        jsonrpc: "2.0"
                    };

                    return err;
                }

                if params is anydata[]{
                    json convertToJson = check value:fromJsonString(params.toString());
                    json madu ={
                        arr: convertToJson
                    };

                    param = check madu.cloneWithType();
                   
                }else{
                    
                    param = check params.cloneWithType();     
                }

                any res = check get(param);
                

                validator:Response response = {
                    id: result.id,
                    result: res,
                    jsonrpc: "2.0"
                };

                return response;
            }

        }
   
        io:println();
        if result is validator:Error{
            return result;
        }  

    }

    // swanlake beta4 support
    return;
}