import ballerina/io;

public function main() returns error?{
    io:println("Ballerina Asynchronus behaviour practice");

    future<int|error> f = start foo(2);
    int|error x = wait f;
    io:println(x);

    // strands

    worker A {
        io:println("In worker A");
    }

    @strand {
        thread: "any"
    }

    worker B {
        io:println("In worker B");
    }

    io:println("In function worker");

    // named worker return value

    int|error answer = trap demo("10m");
    io:println(answer);

    // alternative waits
   
    alternativeWaits();
    
}

function foo(any x) returns int|error{
    if x is int{
        return x;
    }else{
        return error("only intergers are allowed to pass");
    }
}

function demo(string str) returns int|error{
    
    worker A returns int|error{
        int number = check int:fromString(str);
        return number+10;    
    }

    io:println("In function worker demo");

    int answer = check wait A;

    return answer;
}

function alternativeWaits() {
    @strand {
        thread: "any"
    }

    worker C returns int{
        io:println("inside Worker C");
        return 50;
    }

    worker D returns int{
        io:println("inside workder D");
        return 100;
    }

    int z = wait C|D;
    io:println(z);

}