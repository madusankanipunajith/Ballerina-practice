import ballerina/io;

// This is a comment

public function main() {
    io:println("Hello Madusanka"," ","Nipunajith");
    io:println(add(10,20));
    io:println(mult(3,4));
    io:println(divide(20,0));

    // calling functions
    arrayOperations();
}

function add(int x, int y) returns int{
    return x + y;
}

function mult(float x, float y) returns float{
    return x*y;
}

function divide(int x, int y) returns float{
    if (y==0) {
     return 0.0f;   
    }

    float answer = <float>x/<float>y;
    return answer;
}

function arrayOperations() returns (){
    int[] x = [10,20,30,40];
    io:println("Length of x is ", x.length());

    int result = 0;
    foreach int item in x {
        result = result + item;
    }
    io:println("Sumation is ", result);

    int size = x.length();
    int z = 0;
    int sum = 0;
    while z < size {
        sum += x[z];
        z = z+1;
    }
    io:println("Sumation method 2 is ", sum);
}

function mapOperations() returns () {
    map<int> m = {
       "x": 10,
       "y": 20  
    };

    int? val = m["x"];
    io:println(val);
}



