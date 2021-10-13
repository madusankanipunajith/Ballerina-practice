import ballerina/io;

type MapArray map<string>[];    // Local type definitions are not allowed...
type ArrayRecord record {int x; int y;}[];
type Record record {int x; int y;};

type StructuredName record {string first_name; string last_name;};
type Name StructuredName | string;  // union operator....

public function main() {
    io:println("Hello Mdusanka let's try some codes...");
    Name my_name = {first_name:"Madusanka", last_name: "Nipunajith"};
    Name his_name = "Kasun Kalhara";

    mapOperations();
    recodeOperation();
    string name_1 = nameToString(my_name);
    string name_2 = nameToString(his_name);
    io:println(name_1 +" => "+ name_2);
}

function mapOperations() {
    map<int> z = {
        "x" : 10,
        "y" : 20
    };

    int? value = z["x"];

    io:println(value);

    z["z"] = 45;
    io:println(z);
    z["z"] = z.get("x");
    io:println(z);


    MapArray arr = [
        {"x" : "foo"},
        {"y" : "foo2"},
        {"z" : "foo3"}
    ];

    io:println(arr);
    io:println(arr[0].get("x"));

}

function recodeOperation() {
    int? x = ();

    record {int x; int y; string z;} r = {
        x: 1,
        y: 0,
        z: "Madusanka"
    };

    map<int> m = {
        "a": 0,
        "b": 1
    };

    r.x = 40;
    r.y = 50;
    r.z = "Nipunajith";

    io:println(r);

    ArrayRecord rec = [
        {x: 105, y:205},
        {x: 100, y: 200}
    ];

    Record recc = {x:19, y:49};
    rec.push({x: 4000, y: 5000});
    rec.push(recc);
    io:println(rec);
    
}

function nameToString(Name nm) returns string{
    if nm is string{
        return nm;
    }else{
        return nm.first_name+" "+nm.last_name;
    }
}