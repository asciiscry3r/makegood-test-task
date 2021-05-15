terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

variable "zone_id" {
  default = "Z08690643G2MCG6F1C5D7"
}

variable "vpc_id_main" {
  default = "vpc-5b018826"
}

data "aws_vpc" "selected" {
  id = var.vpc_id_main
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "makegood-key" {
  key_name   = "makegood-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDJwRyDnkNifjja1K52u18Sw5ohD63ypTS36A3Kfvq4W8qMvYBAVXwb8Ympah6Pd+xHFzwiJLUdAdk0SzsCpOayQjQ4wwHsbQX0FD01cZM9aYSaWla5sylUeckYATo7bktVUA7GJVUKO3G7LbiNrWSSlouKRuM+OWOYS9nkKzWy1Kd0rODPHeKr5axMHe1l7bCCpfk6+Bduoi2K9YawF1RL08Aujmv5a7N24NwMBiUHPCRRRTFgb/FduuucMIQ2Psv60tCsuNE7NXWNVbv5EfZwKGR3kY0RibAcqp8U2morom18w3b2T3BTshE4YVHedcisWa0e5B08hnuaCguVHFw4xndaNUEWMdgRsmy49jqkb7XPTjXIOuRnbpcqLZeM/12uVWwsGqQkufPwa+s6ZDRnPRf8J7xZM2uFqicJKgl1/q0Q8dTUjdneTBgm0i2NHReZzndLQAIjdApEXrGaTdIxrmlQgHJ2lEAE1QytRLeUcg4mecljHzDTsp7FAKvbUeE= max@mksideapad"
}

resource "aws_security_group" "makegood-allow" {
  name        = "allow_makegood"
  description = "Allow SSH and TLS"
  vpc_id      = var.vpc_id_main

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
#    ipv6_cidr_blocks = [data.aws_vpc.selected.ipv6_cidr_block]
  }

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["108.61.39.2/32"]
#    ipv6_cidr_blocks = [data.aws_vpc.selected.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
#    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "makegood_allow_tls_and access"
  }
}

resource "aws_instance" "makegood-ec2" {
  ami                    = "ami-04cd519d2f9578053"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.makegood-key.key_name
  iam_instance_profile   = "arn:aws:iam:::role/makegood-ec2-access-to-route53"
  vpc_security_group_ids = [aws_security_group.makegood-allow.id]

  provisioner "remote-exec" {
    inline = [
      "git clone https://github.com/asciiscry3r/makegood-test-task.git makegood",
      "cd makegood",
      "chmod +x bootstrap.sh",
      "./bootstrap.sh",
    ]
  }

  tags = {
    Name = "makegood"
  }
}

resource "aws_eip" "makegood-eip" {
  instance = aws_instance.makegood-ec2.id
  vpc      = true
}

resource "aws_route53_record" "makegood-www" {
  zone_id = var.zone_id
  name    = "makegood.mksplayground.online"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.makegood-eip.public_ip]
}

