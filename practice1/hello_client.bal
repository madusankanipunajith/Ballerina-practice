import ballerina/http;
import ballerina/io;

public function main() returns @tainted error? {
    http:Client helloClient = check new("http://localhost:9090/hello");
    http:Response helloResponse = check helloClient->get("/sayHello");

    io:println(helloResponse.getTextPayload());
}
