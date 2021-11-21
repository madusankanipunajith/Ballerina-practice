import madusanka.json_input;
import madusanka.method_handler;
import madusanka.validator;
import madusanka.runner;
import ballerina/io;

// user defined record types
type Nip record {|
    int x;
    int y;
|};

type Sip record {|
    int[] arr;
|};

// json rpc messages come from client
string str = "{\"jsonrpc\":\"2.0\",\"method\":\"add\",\"params\":{\"x\":89, \"y\":100},\"id\":10}";
string str2 = "{\"foo\": \"boo\"}";
string str3 = "[{\"jsonrpc\":\"2.0\",\"method\":\"add\",\"params\":{\"x\":89, \"y\":100},\"id\":10}, {\"jsonrpc\":\"2.0\",\"method\":\"subs\",\"params\":{\"x\":89, \"y\":100},\"id\":10}]";
string str4 = "{\"jsonrpc\":\"2.0\",\"method\":\"mult\",\"params\":[10,20,30],\"id\":10}";
string str5 = "{\"jsonrpc\":\"2.0\",\"method\":\"mult\",\"params\":550,\"id\":10}";

public function main() returns error?{
    
    check method_handler:myFunction("add", addFunction);
    check method_handler:myFunction("sub", addFunction);

    // This executor function is running dynamically. user doesn,t need to code this. for testing I have run it in main method
   validator:Error|validator:Response|runner:BatchResponse|error? response = runner:executor(str3);
   io:println(response);
}

public function addFunction(json_input:InputFunc ifs) returns int|error{
  json nips = <json> ifs;
  Nip nip = check nips.cloneWithType();
  return nip.x + nip.y;
}