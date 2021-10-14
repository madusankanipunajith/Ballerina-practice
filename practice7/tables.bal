import ballerina/io;

type Employee record {
    readonly string name;
    string company;
    int salary;
};  // keys can be primary key | composite key | record key(structured key)

type EmployeeWife record {|
    readonly int wifeId;
    string hus_name;
    string name;
|};

public function main() {
    io:println("Tables in ballerina....");

    table<Employee> key(name) t = table [
        {name: "madusanka", company: "WSO2", salary: 20000},
        {name: "kasun", company: "99X", salary: 20000},
        {name: "roshel", company: "omobio", salary: 15000}
    ];

    Employee? e = t["nimal"];
    Employee? e2 = t["kasun"];

    io:println(e2);
    io:println(e);

    listEmployees(t);
    increaseSalary(t);
    listEmployees(t);
    
    io:println(getSalaries(t));


    // join tables
    table<EmployeeWife> key(wifeId) wt = table[
        {wifeId: 0, hus_name: "madusanka", name: "-"},
        {wifeId: 1, hus_name: "kasun", name: "chamika"},
        {wifeId: 2, hus_name: "roshel", name: "ariyawathi"},
        {wifeId: 3, hus_name: "nimal", name: "yohani"}
    ];

    EmployeeWife? ef = wt[0];
    io:println(ef);

    string[] result = from Employee husband in t join EmployeeWife wife in wt on husband.name equals wife.hus_name select husband.name+" => "+husband.company+" => "+wife.name;
    io:println(result);
    
}


function listEmployees(table<Employee> t) {
    foreach Employee item in t {
        io:println(item.name+" => "+ item.company+" => ", item.salary);
    }
}

function increaseSalary(table<Employee> t) {
    foreach Employee item in t {
        item.salary += 10000;
    }
}

function getSalaries(table<Employee> t) returns int[]{
    int[] salaries = from var {salary} in t where salary > 0 select salary;

    return salaries;
}