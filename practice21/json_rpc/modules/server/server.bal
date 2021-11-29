import json_rpc.caller;
import json_rpc.validator;
import json_rpc.store;
import ballerina/lang.value;

type MapFunctionType isolated function (store:Input) returns any|error;
type BatchResponse validator:JsonRPCTypes?[]; 

# User Input parameters  
type InputFunc record {|
    
    anydata...;

|};

public type Input InputFunc|anydata[];

public isolated class Server {
    private map<isolated function (store:Input func) returns any|error> methodMapper = {};

    private isolated function addFunction(string method,isolated function (store:Input) returns any|error servFunc) returns error?{
                  
            lock {
                
                if (self.methodMapper[method] is null) {
                
                    self.methodMapper[method] =  servFunc.clone();     
    
                }else{

                    return error("same request method name cannot be applied...");
                }

            }
        
    }

    private isolated function methodFilter(string message) returns MapFunctionType?{
        validator:JsonRPCTypes|error result = trap validator:messageValidator(message);

        if result is validator:Request{
            string method = result.method;

            lock {
                if !(self.methodMapper[method] is null){
                    return self.methodMapper[method];
                }
            }
        }

        return null; 
    }

    private isolated function executeSingleJson(string message) returns validator:Error|validator:Response?{
        validator:Request|validator:Error|null output = caller:checker(message);

        if output is validator:Request{
            MapFunctionType? mf = self.methodFilter(message);

            if mf is null{
                return store:methodNotFoundError(output.id);
            }

            return checkpanic caller:executor(output, mf);
        }

        else if output is validator:Error {
            return output;
        }

        else {
            return null; 
        }

    }

    private isolated function executeBatchJson(string message) returns BatchResponse{
        BatchResponse batch_res_array = [];
        any z = checkpanic value:fromJsonString(message);

        if z is any[]{
            foreach var item in z {
                batch_res_array.push(self.executeSingleJson(item.toString()));
            }

            return batch_res_array;
        }

        return []; 
    }

    public isolated function runner(string message) returns validator:JsonRPCTypes|BatchResponse?{
        int batchChecker = caller:batchChecker(message);

        match batchChecker {
            0 =>{
                return store:invalidRequestError();
            }
            1 =>{
                return self.executeBatchJson(message);
            }
            2 =>{
                return store:parseError();
            }
            3 =>{
                return self.executeSingleJson(message);
            }
            _ =>{
                return store:serverError();
            }
        }
 
    }

    public isolated function serverFunction(string method, isolated function (store:Input) returns any|error servFunc){
        
        checkpanic self.addFunction(method,servFunc);
    }
}