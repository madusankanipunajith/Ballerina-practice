import ballerina/io;

type Employee record {
    string name;
    string company;
    int age;
    string hobby?;
};

type Person record {
    string name;
};

// controlling the openness
type Student record {|
    int id;
    string name;
    string shool;
|};

public function main() {
    io:println("anydata advance....");

    Employee emp =  {
      name: "Madusanka",
      company: "WSO2",
      age: 24
    };

    Employee emp2 = {
        name: "Nipunajith",
        age: 28,
        company: "WSO2",
        hobby: "playing cricket",
        "weight": 68
    };

    io:println(emp);
    io:println(emp2);

    emp.age = 40;
    Person p = emp;

    map<anydata> m = emp;
    io:println(m);
    io:println(p);
}

