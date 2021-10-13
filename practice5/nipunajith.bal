import ballerina/io;

public function main() {

    anydata x = [10,"hello", 50];
    any y = x.clone();
    any z = x.cloneReadOnly();

    // create an object without class
    var obj = object {
        function greeting() {
            io:println("This is a method inside the object");
        }
    };

    myClass f_object = new myClass(10,20);
    
    f_object.display();
    obj.greeting();
    io:println(y);
    io:println(z);
}       

class myClass {
    private int my_age;
    private int friend_age;

    function init(int x, int y) {
        self.my_age = x;
        self.friend_age = y;    
    }

    public function display() {
        io:println("my age is ", self.my_age," and my friend's age is ",self.friend_age);
    }
}