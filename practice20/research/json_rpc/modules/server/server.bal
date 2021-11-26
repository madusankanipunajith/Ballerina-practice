import json_rpc.validator;
import json_rpc.runner;


# Request parameters of the JSON message are filtered and stored  
public type InputFunc record {|
    
    anydata...;

|};

isolated string[] stack = [];
isolated string answer = "";
isolated validator:Error|validator:Response|runner:BatchResponse|error? executor = null;
type serExecutor function(string message, map<function (InputFunc func) returns any|error> serMapper) returns validator:Error | validator:Response | runner:BatchResponse | error?;

public isolated class Server {
    // private access
    private map<isolated function (InputFunc func) returns any|error> methodMapper = {};
    private serExecutor serverExecutor;

    private isolated function addFunction(string method, isolated function (InputFunc) returns any|error servFunc) returns error?{
        
        lock {

            if (self.methodMapper[method] is null) {
                
                self.methodMapper[method] =  servFunc.clone();     
    
            }else{

                return error("same request method name cannot be applied...");
            }
        }
        
    }

    private isolated function catcher(string message) returns string|error?{
       return;  
    }

    public function init() {
        self.serverExecutor = runner:executor;  
    }

    public isolated function serverFunction(string method,isolated function (InputFunc) returns any|error servFunc){
        
        checkpanic self.addFunction(method,servFunc);
    }

    public isolated function messageCatcher(string message) returns string|error?{
                
        lock {
                       
          validator:Error|validator:Response|runner:BatchResponse|error? executorResult = runner:executor(message, self.methodMapper);                
               
        }

    return;   
    }
    
}
