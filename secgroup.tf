/*
resource "aws_security_group" "allow_ssh" {
  vpc_id = "${aws_vpc.Bancroft_Group.id}"
  name = "allow_ssh"
  description = " Allow SSH + RDP"
  tags {
    Name ="ALLOW_REMOTE"
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["196.52.2.107/32"]
  }
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["196.52.2.107/32"]
  }
  ingress {
    from_port = 3389
    protocol = "tcp"
    to_port = 389
    cidr_blocks = ["196.52.2.107/32"]
  }
}

*/

resource "aws_security_group" "Internal-SG" {
  vpc_id = "${aws_vpc.Bancroft_Group.id}"
  name = "Inernal-SG"
  description = "Internal-SG"
  tags {
    Name = "INTERNAL-SG"
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["10.10.0.0/24"]

  }
}

resource "aws_security_group" "Bastion_host" {
  vpc_id = "${aws_vpc.Bancroft_Group.id}"
  name = "bastion_host"
  description = "Bastion_host"

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["209.95.51.22/32"]
  }
  ingress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["209.95.51.22/32"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "sophos_int_sg" {
  vpc_id = "${aws_vpc.Bancroft_Group.id}"
  name = "sophos_internal_sg"
  description = " internal interface for sophos"
  tags {
    Name = "SOPHOS_INT_SG"
  }

  ingress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = [
      "196.52.2.107/32", "10.10.0.0/24"]

  }
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["10.10.0.0/24"]
  }
  ingress {
    from_port = 4444
    protocol = "tcp"
    to_port = 4444
    cidr_blocks = ["10.10.0.0/24"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_remote" {
  vpc_id = "${aws_vpc.Bancroft_Group.id}"
  name = "allow_remote"
  description = "allow remote access"
  tags {
    Name = "ALLOW REMOTE ACCESS"
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    protocol = "tcp",
    to_port = 22
    cidr_blocks = ["209.95.51.22/32"]
  }
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["209.95.51.22/32"]
  }
  ingress {
    from_port = 3389
    protocol = "tcp"
    to_port = 3389
    cidr_blocks = ["209.95.51.22/32"]
  }
}

resource "aws_security_group" "test_security_group" {
  ingress {
    from_port = 0
    protocol = "tcp"
    to_port = 22
    cidr_blocks = [" 209.95.51.22/32", "63.88.1.114/32", "10.10.10.10/32"]
   # security_groups = ["sg-XXXXX"]


  }
  tags {
    Name = "test_security_group"
  }
}



