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
   records = [aws_instance.ec2[each.key].private_ip]

}

provisioner "remote-exec" {

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = self.public_ip
  }

  inline = [
    "sudo dnf install python3.13-pip -y",
    "pip3.13 install ansible",
    "ansible-pull -U https://github.com/hsompura2012-web/Ansible_v3.git -i localhost, main.yaml -e component=${each.key}"
  ]
}