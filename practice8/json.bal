import ballerina/io;

public function main() returns error?{

    io:println("json section practice");

    //topic : json basics

    json jsn = {
        name: "madusanka",
        age: 24
    };

    string jsnString = jsn.toJsonString(); // json object is convirted into string
    io:println(jsnString);

    json jsnVersion = check jsnString.fromJsonString(); // jsonstring object is convirted into json
    io:println(jsnVersion);

    
    //topic : working dirrectly with json

    json jsn1 = {
        x: {
            y: {
                z: "ballerina",
                w: 21
            }
        }
    };

    json|error j = trap jsn1.x.y.w;
    io:println(j);
    io:println("Hi");

    // ensure types with mapping under match
    
    error?err = foo(jsn);
    if err is error{
        io:println(err);
    }

    // by using toJson() method we can convirt our own record into json type object
    // by using cloneReadonly() method we can convirt json type object to our own record (same as cloneWithType())

    // resource method typing

    // json numbers

    int a = 10;
    float b = 2.5;
    decimal c = 10.6;

    json[] jsna = [a,b,c]; // json number has only one type. not like numeric types
    string jsnaString = jsna.toJsonString();
    io:println(jsnaString);

    json f = check jsnaString.fromJsonString();
    io:println(f);

    json[] g = <json[]> f;
    io:println(g[0]);
    io:println(g[1]);

    int jsint = check g[0].cloneWithType(int);
    io:println(jsint);

}

function foo(json j) returns error?{
    match j{
        {name:"madusanka", age: var x} =>{
            int age = check x.ensureType(int);
            io:println("madusanka's age is ",age); 
        }
        _ => {return error("something went wrong");}
    }
}