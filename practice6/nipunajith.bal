import ballerina/io;
//import ballerina/lang.value;
//import ballerina/http;
//import ballerina/udp;


type Record record {string name; int age; string company;};
type RecordArray record {string name; int age; string company?;}[];

json[] ja = [{name: "madusanka", age:24, company: "WSO2"},{name: "kasun", age:27, company: "99X"},{name: "madusha", age:21}];

public function main() returns error? {
    io:println("JSON advance value convirsion...");

    json j ={
        name: "madusanka",
        age: 24,
        company: "WSO2"
    };

    Record rec = check j.cloneWithType();
    RecordArray recc = check ja.cloneWithType();

    io:println(rec.name);
    io:println(recc);

    string[] mapResult = recc.map((x) => x.name);
    
    io:println(mapResult);
    ()[]mapResult2 = recc.map((val) => io:println(val.name," ", val.age));
    io:println(mapResult2);
}