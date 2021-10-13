import ballerina/io;

type MyFunction function (int n) returns boolean;

public function main() {

    MyFunction f = isEven;
    int[] nums = [1,2,3,4,5,6,7,8,9,10];

    int[] evenNumbers = nums.filter(f);
    io:println(evenNumbers);

    // another method
    int[] oddNumbers = nums.filter(n => n%2 != 0);
    io:println(oddNumbers);
    
}

var isOdd = function(int n) returns boolean {
    return n%2 != 0;
};

var isEven = function(int n) returns boolean{
    return n%2 == 0;
};