import madusanka.json_input;
import madusanka.method_handler;
import madusanka.services;
import ballerina/tcp;

// user defined record types
type Nip record {|
    int x;
    int y;
|};

type Sip record {|
    int[] arr;
|};


public function main() returns error?{
    
    check method_handler:myFunction("add", addFunction);
    check method_handler:myFunction("sub", addFunction);

   
}


service on new tcp:Listener(8090) {
    // connection is established
    remote function onConnect(tcp:Caller caller) returns tcp:ConnectionService | tcp:Error?{
        tcp:ConnectionService | tcp:Error res = services:defService();
        return res;
    }
}


// user define functions
public function addFunction(json_input:InputFunc ifs) returns int|error{
  json nips = <json> ifs;
  Nip nip = check nips.cloneWithType();
  return nip.x + nip.y;
}

public function subFunction(json_input:InputFunc ifs) returns int|error{
  json nips = <json> ifs;
  Nip nip = check nips.cloneWithType();
  return nip.x - nip.y;
}