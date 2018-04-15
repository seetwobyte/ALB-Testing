# test

resource "aws_instance" "Nginx-1" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  monitoring = true
  count = 1
  # the VPC subnet
  subnet_id = "${aws_subnet.pub_subnet_1.id}"
  # the security group
  vpc_security_group_ids = ["${aws_security_group.allow_remote.id}"]
  key_name = "${aws_key_pair.linux1.key_name}"
  # the public SSH key

    tags {
      Name = "NGINX-1"
    }

  }

resource "aws_instance" "Nginx-2" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  monitoring = true
  count = 1
  # the VPC subnet
  subnet_id = "${aws_subnet.pub_subnet_2.id}"
  # the security group
  vpc_security_group_ids = ["${aws_security_group.allow_remote.id}"]
  # the public SSH key
  key_name = "${aws_key_pair.linux1.key_name}"
    tags {
      Name = "NGINX-2"
    }

  }

  # test
/*
resource "aws_instance" "Bastion_Host" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  monitoring = true
  count = 1
  subnet_id = "${aws_subnet.pub_subnet_1.id}"
  vpc_security_group_ids = ["${aws_security_group.Bastion_host.id}"]
  key_name = "${aws_key_pair.linux1.key_name}"
  tags {
    Name = "Bastion_Host"
  }
}

resource "aws_instance" "Web_server1" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  monitoring = true
  count = 1
  subnet_id = "${aws_subnet.web_subnet_1.id}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  key_name = "${aws_key_pair.linux1.key_name}"
  tags {
    Name = "web_server1"
  }
}

resource "aws_instance" "Web_server2" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  monitoring = true
  count = 1
  subnet_id = "${aws_subnet.web_subnet_2.id}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  key_name = "${aws_key_pair.linux1.key_name}"
  tags {
    Name = "web_server2"
  }
}
*/

resource "aws_instance" "VPN-Sophos" {
  ami = "ami-0fc06119"
  instance_type = "m4.large"
  availability_zone = "us-east-1b"
  ebs_optimized = false
  monitoring = true
  subnet_id = "${aws_subnet.pub_subnet_2.id}"
  vpc_security_group_ids = ["${aws_security_group.sophos_int_sg.id}"]
  associate_public_ip_address = true
  tags {
    Name = "VPN-SOPHOS"
  }

}


resource "aws_instance" "VPN-Sophos-2" {
  ami = "ami-0fc06119"
  instance_type = "m4.large"
  availability_zone = "us-east-1b"
  count = 1
  ebs_optimized = false
  monitoring = true
  subnet_id = "${aws_subnet.pub_subnet_2.id}"
  vpc_security_group_ids = ["${aws_security_group.sophos_int_sg.id}"]
  associate_public_ip_address = true
  tags {
    Name ="VPN-SOPHOS-2"
  }

}

resource "aws_instance" "Bastion_Windows" {
  ami = "ami-ed14c790"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  associate_public_ip_address = true
  subnet_id = "${aws_subnet.pub_subnet_1.id}"
  key_name = "${aws_key_pair.linux1.key_name}"

  vpc_security_group_ids = ["${aws_security_group.allow_remote.id}"]
  monitoring = false
  tags {
    Name = "BASTION_WINDOWS"
  }
}

resource "aws_instance" "Jenkins_CI_CD" {
  ami = "ami-1853ac65"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.mgmt_subnet_1.id}"
  key_name = "${aws_key_pair.linux1.key_name}"

  vpc_security_group_ids = ["${aws_security_group.Internal-SG.id}"]
  monitoring = false

  tags {
    Name = "JENKINS"
    Purp = "CI CD"
  }

}


########### Elastic Network Interfaces #################

resource "aws_network_interface" "vpn-sophos-int" {
  subnet_id = "${aws_subnet.sophos_int_subnet_2.id}"
  private_ips = ["10.10.2.230"]
  security_groups = ["${aws_security_group.sophos_int_sg.id}"]
  description = "sophos_int_230"
  tags {
    Name = "vpn-sophos-int"
  }

  }

resource "aws_network_interface" "vpn-sophos-2-int" {
  subnet_id = "${aws_subnet.sophos_int_subnet_2.id}"
  private_ips = ["10.10.2.240"]
  security_groups = ["${aws_security_group.sophos_int_sg.id}"]
  description = "sophos-2_int_240"
  tags {
    Name = "vpn-sophos-2-int"
  }

  }


########################################################
/*
  provisioner "remote-exec" {
    inline = [
    "sudo yum install nginx -y",
    "sudo service nginx start",
    ]
  }
  tags {
    Name = "Nginx-1"
  }

}

*/


