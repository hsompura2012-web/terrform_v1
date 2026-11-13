variable "ami" {
    default = "ami-0055977a6e828a4f4"
}

variable "instance_type"{
    default="t3.micro"
}

variable "zone_id" {
    default="Z03480463A1JR2GW8CJL3"
}

variable "component" {
     frontend=""
     mongodb=""
     catalogue=""
     redis=""
     user=""
     cart=""
     mysql=""
     shipping=""
     rabbitmq=""
     payment=""
     dispatch=""     
}