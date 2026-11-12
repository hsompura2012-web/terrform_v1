resource "aws_instance" "frontend" {
    ami = "ami-0055977a6e828a4f4"
    instance_type = "t3.micro"

    tags = {
        Name= "frontend"
    }
}

resource "aws_route53_record" "frontend53" {
   zone_id = "Z03480463A1JR2GW8CJL3" 
   name = "frontend.harshitsompura.online"
   type = "A"
   ttl = 300
   records = [aws_instance.frontend.private_ip]

}