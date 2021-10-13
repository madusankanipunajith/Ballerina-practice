import ballerina/io;

public function main() returns error?{
    future<int> f1 = start add(10,20);
    future<int> f2 = start mult(10,10);

    future<int> f3 = start add(10,20);
    future<int> f4 = start mult(10,10);

    var f = wait {f1, f2};
    io:println(f);
    io:println(f["f1"]);
    io:println(f["f2"]);

    // second method
    int x1 = check wait f3;
    int x2 = check wait f4;

    io:println("x1 :",x1," x2 :",x2);

    f1.cancel();
    f2.cancel();
}

function add(int x, int y) returns int{
    if(x==0 && y==0){
        panic error("both values are zero");
    }
    return x+y;
}

function mult(int x, int y) returns int{
    if(x==0 && y==0){
        panic error("both values are zero");
    }
    return x*y;
}