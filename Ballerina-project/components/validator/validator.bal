import ballerina/io;

type JsonRecord record {|
    int id?;
    string method?;
    string result?;
    map<anydata> params?;
    string jsonrpc?;
|};



public function main() returns error?{
    // testing purposes

    string str = "{\"jsonrpc\":\"2.0\",\"method\":\"display\",\"params\":{\"number\":89, \"street\":\"main street\", \"town\":\"Colombo\"},\"id\":10}";
    string str2 = "{\"id\":10,\"result\":\"this is the result came from server\",\"jsonrpc\":\"2.0\"}";
    
    int|error result = messageValidator("server",str);
    int|error result2 = messageValidator("client", str2);

    io:println(result);
    io:println(result2);
}

function messageValidator(string host, string jsonString) returns int|error{

    // 0 -> notification
    // 1 -> request message
    // 2 -> response message
    // 3 -> invalid message

    io:StringReader sr = new(jsonString, encoding = "UTF-8");
    json message = check sr.readJson();

    JsonRecord|error jr = message.cloneWithType();

    if jr is error{
        return error("code: 500, desc: internal server error");

    }else{

            int? id = jr?.id;
            string? method = jr?.method;
            string? jsonrpc = jr?.jsonrpc;
            string? result = jr?.result;
            map<anydata>? params = jr?.params;

        if(host === "server"){

            io:println("version is always 2.0");
            io:println("method : ", jr?.method);
            io:println("params : ", jr?.params);
            io:println("id : ", jr?.id);

            if (method is null || jsonrpc is null || params is null) {
                return 3;
            }else{
                if id === () {
                    return 0;
                }else{
                    return 1;
                }
            }

        }else if(host === "client"){
            io:println("iside the client proxy");

            if (result is null || id === () || jsonrpc is null){
                return 3;
            }else{
                return 2;
            }

        }else {
            return error("code: 404 , desc: invalid host is found or host is not defined");
        }

    }
 
}