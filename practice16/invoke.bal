import ballerina/io;
import ballerina/jballerina.java;

// functions are called externally

public function createRandomUUID() returns handle = @java:Method {
    name: "randomUUID",
    'class: "java.util.UUID"
}external;


# If your method name and java member function name is same, you don't need to specify the name again
# + return - Return Value Description  
public function newArrayDeque() returns handle = @java:Constructor {
    'class: "java.util.ArrayDeque"
}external;


public function offer(handle reciever, handle e) returns boolean = @java:Method {
    'class: "java.util.ArrayDeque"
}external;


public function poll(handle receiver) returns handle = @java:Method {
    'class: "java.util.ArrayDeque"
} external;


public function getMethods() returns handle = @java:Method {
    'class: "java.lang.Class"
}external;


public class Test {
    
    private string name;

    function setNames(string name) {
        self.name = name;
    }
}


public function main() returns error?{
    var uid = createRandomUUID();
    io:println(typeof uid);

    var arrayDeque = newArrayDeque();

    _ = offer(arrayDeque, java:fromString("madusanka"));
    _ = offer(arrayDeque, java:fromString("Jane"));
    _ = offer(arrayDeque, java:fromString("Peter"));

    io:println(arrayDeque);

    var nextInLineHandle = poll(arrayDeque);
    io:println(nextInLineHandle);
    io:println(arrayDeque);


    
}