import ballerina/io;
import ballerina/tcp;

public function main() returns error?{
    string name = io:readln("Enter your name :");

    tcp:Client socketClient = check new("localhost", 3000);

    byte[] msgByteArray = name.toBytes();
    check socketClient->writeBytes(msgByteArray);

    check socketClient->close();

}