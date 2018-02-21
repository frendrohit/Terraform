provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "webserver" {
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "${var.cidr_block}"

  tags {
    Name = "my_vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = "${aws_vpc.my_vpc.id}"
  cidr_block = "${var.public_subnet_cidr_block}"

  tags {
    Name = "public_subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = "${aws_vpc.my_vpc.id}"
  cidr_block = "${var.private_subnet_cidr_block}"

  tags {
    Name = "private_subnet"
  }
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow tcp inbound traffice"
  vpc_id      = "${aws_vpc.my_vpc.id}"

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "Allow all tcp inbound traffic"
  }
}
