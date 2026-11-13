resource "aws_instance" "ec2" {
    for_each = var.component
    ami = var.ami
    instance_type = "t3.micro"

    tags = {
        Name= each.key
    }
}

resource "aws_route53_record" "ec2_53" {
   for_each = var.component 
   zone_id = var.zone_id
   name = "${each.key}.harshitsompura.online"
   type = "A"
   ttl = 300
   records = [aws_instance.${each.key}.private_ip]

}