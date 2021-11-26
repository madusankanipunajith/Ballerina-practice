import json_rpc.validator;
import json_rpc.runner;
// import json_rpc.caller;

public type T validator:Error|validator:Response|runner:BatchResponse|error?;

isolated T[] stack = [];

// isolated function F(string msg, map<isolated function (caller:InputFunc func) returns any|error> serverMapper) returns T{

//         lock {
//             //stack.push(runner:executor(msg, serverMapper));  
//             return runner:executor(msg, serverMapper);  
//         }
        
    
// }