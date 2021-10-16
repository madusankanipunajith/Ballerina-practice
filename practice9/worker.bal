import ballerina/io;

public function main() {
    string name = "Madusanka";
    io:println("This is worker DS practice....");

    worker work_1 {
        io:println(name+ " is working at WSO2...");
    }

    worker work_2 {
        io:println(name+ " has a sister...");
    }

    worker work_3 {
        io:println("This is VIP worker");
    }

    wait work_3;

    io:println("This is the line defined after the VIP workers");
}