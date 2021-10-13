import ballerina/io;
import ballerina/email;

public function main() returns error?{
    email:SmtpClient sc = check new("smtp.gmail.com","madushankanipunajith@gmail.com","#your password#");

    // prerequist 
    string to = "madusanka@wso2.com";
    string subject = "This is the subject";
    string froms = "madushankanipunajith@gmail.com";
    string body = "This is testing body";

    email:Error? response = check sc->send(to,subject,froms ,body, sender="madusanka");

    if (response is email:Error) {
        io:println("Error while sending the email: ", email:Error);
    }else{
        io:println("message sent succesfully");
    }
}