import ballerina/test;

class Person {
     public string name = "";
     public int age = 0;
     public Person? parent = ();
     private string email = "default@abc.com";
     string address = "No 20, Palm grove";
}

@test:Config{}
function testAssertIntEquals() {
    int answer = 0;
    int a = 5;
    int b = 3;
    answer = intAdd(a, b);
    test:assertEquals(answer, 8, msg = "int values not equal");
}

@test:Config {}
function testAssertNotEqualsString() {
    string s1 = "abc";
    string s2 = "def";
    test:assertNotEquals(s1, s2, msg = "string values are equal");
}

@test:Config {}
function testAssertExactEqualsObject() {
    Person p1 = new;
    Person p2 = p1;
    test:assertExactEquals(p1, p2, msg = "Objects are not exactly equal");
}

@test:Config {}
function testAssertNotExactEqualsObject() {
    Person p1 = new;
    Person p2 = new ();
    test:assertNotExactEquals(p1, p2, msg = "Objects are exactly equal");
}

@test:Config {}
function testAssertTrue() {
    boolean value = true;
    test:assertTrue(value, msg = "AssertTrue failed");
}

@test:Config {}
function testAssertFalse() {
    boolean value = false;
    test:assertFalse(value, msg = "AssertFalse failed");
}

@test:Config {}
function testAssertFail() {
    if (true) {
        return;
    }
    test:assertFail(msg = "AssertFailed");
}

function intAdd(int a, int b) returns (int) {
    return (a + b);
}