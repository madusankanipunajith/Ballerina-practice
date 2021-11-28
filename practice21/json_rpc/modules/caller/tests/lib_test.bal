import ballerina/test;
import json_rpc.store;
import json_rpc.validator;
import ballerina/io;

type Nip record {|
    int x;
    int y;
|};

public function addFunction(store:Input ifs) returns int|error{
  Nip nip = check ifs.cloneWithType();
  return nip.x + nip.y;
}

validator:Request r={
    id: 10,
    params: "{\"x\":89, \"y\":100},\"id\":10}",
    method: "add",
    jsonrpc: "2.0"
};

@test:BeforeEach
public function startTesting() {
    io:println("Testing is starting...");
}
@test:Config{}
public function testExecutor() {
    
}