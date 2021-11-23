import madusanka.store;



# Description
#
# + method - User Define Method Name 
# + x - User Define Function
# + return - Return Value Is error otherwise nothing is retured  
public function myFunction(string method, function (store:InputFunc) returns any|error x) returns error?{

    if (store:methodMapper[method] is null) {
     
        store:methodMapper[method] =  x.clone();     
    
    }else{
        return error("same request method name cannot be applied...");
    }
   
}




// function get(function (string, int) returns int func) returns error?{
    
// }
