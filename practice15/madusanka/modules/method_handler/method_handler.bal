import ballerina/random;

int x = 100;
public function getX() returns int{
    return x;
}

type nipFunc function (int x) returns int;

# Description about method class
public class method{
    
    private string name;
    private int id;
    private int number;
    private nipFunc cf;

    public function init(string method_name, function x, int number){
        self.cf = <nipFunc> x.clone();
        self.name = method_name;
        self.id = <int> random:createDecimal();
        self.number = number;
    }

    public function getFunction() returns function {
        return self.cf;
    }

    public function getResult() returns int{
        int ans = self.cf(self.number);
        return ans;
    }
    
}










