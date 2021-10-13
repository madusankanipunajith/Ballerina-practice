import ballerina/io;

string[] myArray = ["madusanka", "Sandun","Kasun", "Ruwan"];

public function main() returns error?{
    io:println("This is belongs to the OOP....");

   File f = check new File("madusanka.txt");

   io:println("file name is ", f.getPath());
   io:println("file content is ", f.getContent());

   io:println(matchFunction(10));
   arrayForEach(myArray);
}

class File {
    string path;
    string content;

    public function init(string p) returns error? {
        self.path = p;
        self.content = check io:fileReadString(p);            
    }

    public function getContent() returns string{
        return self.content;
    }

    public function getPath() returns string{
        return self.path;
    }

}


public function matchFunction(any value) returns string {
    match value {
        1 => {return "number";}
        true => {return "boolean";}
        0|2 => {return "or";}
        _ => {return "any";}
    }
}

function arrayForEach(string[] arr) {
    foreach string item in arr {
        io:println(item);
    }
}