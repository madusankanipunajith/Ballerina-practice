import ballerina/io;

type Person record {
    string f_name;
    string l_name;
    int age;
};

public function main() {
    int[] nums = [10,20,30,40,50];

    Person[] p = [{f_name: "madusanka", l_name: "nipunajith", age: 24},{f_name: "lional", l_name: "nipunajithson", age: 20},{f_name: "madushankanipunajith", l_name: "", age: 20},{f_name: "kasun", l_name: "soyza", age: 60}];

    // Query-like expression
    int[] result = from var i in nums select i*10;
    int[] evens = from var i in nums where i%2 == 0 select i;

    // destructuring 
    var names = from var {f_name, l_name} in p select {f_name, l_name};  

    // let keywords (pipelines)
    string[] full_names = from var {f_name, l_name} in p let int len_1 = f_name.length() where len_1 > 0 select f_name+" "+l_name;
    string[] full_names_asc = from var {f_name, l_name} in p where f_name.length() > 0 order by f_name ascending select f_name + " "+ l_name; 
    string[] full_names_asc2 = from var item in p where item.f_name.length() > 0 order by item.f_name ascending select item.f_name + " "+ item.l_name;

    io:println(result);
    io:println(evens);
    io:println(names);
    io:println(full_names);
    io:println(full_names_asc);
    io:println(full_names_asc2);

}