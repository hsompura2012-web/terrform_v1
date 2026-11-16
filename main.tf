resource "aws_instance" "ec2" {
    for_each = var.component
    ami = var.ami
    instance_type = "t3.micro"
    vpc_security_group_ids = var.sg_id

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

resource "null_resource" "ansible" {
  
  depends_on = [
    aws_instance.ec2,
    aws_route53_record.ec2_53
  ]
  for_each = var.component
  provisioner "remote-exec" {
  
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.ec2[each.key].public_ip
  }

  inline = [
    "sudo dnf install python3.13-pip -y",
    "pip3.13 install ansible",
    "ansible-pull -U https://github.com/hsompura2012-web/Ansible_v3.git -i localhost, main.yaml -e component=${each.key}"
  ]
}

}

