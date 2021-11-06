import ballerina/io;
import project_2.madusanka;

public function main() {
    string name = madusanka:hello("Madusanka");
    io:println(name);
}