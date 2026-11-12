resource "aws_instance" "frontend" {
    ami = "ami-0055977a6e828a4f4"
    instance_type = "t3.micro"

    tags {
        Name= "frontend"
    }
}