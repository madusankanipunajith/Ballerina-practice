import ballerina/io;

type Result float | error;
public function main() {
    io:println("Second prhase of the practicing");

    // Result res = divide(12,0);
    // io:println(res);

    float z = divide(12,5);
    io:println(z);


    any s = 1;
    float number = <float>s;
    string number_s = s.toString();
    io:println(number);
    io:println(number_s);
}

function divide(float x, float y) returns float{
    if(y == 0.0){
        panic error("Y cannot be zero");
    }

    return x/y;
}