import json_rpc.validator;
//import ballerina/lang.value;
import json_rpc.store;
import ballerina/io;


# Description
#
# + request - Parameter Description  
# + func - Parameter Description
# + return - Return Value Description  
public function executor(validator:Request request, function (store:Input func) returns any|error func) returns validator:Response|error|null{

    function (store:Input) returns any|error abstractFunction = func.clone();
    anydata parameters = request.params;
    store:Input fetchedParameters;

    if parameters === () {

        json P = {data: null};

        fetchedParameters = check P.cloneWithType();

        any _ = check abstractFunction(fetchedParameters);    
            
            return null; 
            
    }

    if parameters is anydata[]{

        // json convertToJson = check value:fromJsonString(parameters.toString());
                    
        // json M ={ arr: convertToJson};

        // fetchedParameters = check M.cloneWithType();

        fetchedParameters = parameters;
                   
    }else{
                    
        fetchedParameters = check parameters.cloneWithType(); 
        io:println(typeof fetchedParameters);
            
    }

        any res = check abstractFunction(fetchedParameters);

        return store:responseObject(request.id, res);

}





