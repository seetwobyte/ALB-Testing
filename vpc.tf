# Building out the VPC

resource "aws_vpc" "Bancroft_Group" {
  cidr_block = "10.10.0.0/20"
  enable_dns_hostnames = "true"
    tags {
      Name = "Bancroft_Group_VPC"
    }

}

##########Internet Gateway#################
resource "aws_internet_gateway" "IGW" {
  vpc_id = "${aws_vpc.Bancroft_Group.id}"
}

############Route tables######################
resource "aws_route_table" "rtb" {
  vpc_id = "${aws_vpc.Bancroft_Group.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.IGW.id}"
  }
}

############route table association###############
resource "aws_route_table_association" "main" {
  route_table_id = "${aws_route_table.rtb.id}"
  subnet_id = "${aws_subnet.pub_subnet_1.id}"
  subnet_id = "${aws_subnet.pub_subnet_2.id}"
}

############ Subnets #################

resource "aws_subnet" "pub_subnet_1" {
  cidr_block = "10.10.0.0/25"
  vpc_id = "${aws_vpc.Bancroft_Group.id}"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-1a"

    tags {
      Name = "PUBLIC_SUBNET"

    }
}
resource "aws_subnet" "pub_subnet_2" {
  cidr_block = "10.10.0.128/25"
  vpc_id = "${aws_vpc.Bancroft_Group.id}"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-1b"

tags {
  Name = "PUBLIC_SUBNET"
}
}

############# Web Sebnets ####################
resource "aws_subnet" "web_subnet_1" {
  cidr_block = "10.10.1.0/25"
  vpc_id = "${aws_vpc.Bancroft_Group.id}"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-1a"

    tags {
      Name = "WEB_SUBNET_1"

    }
}
resource "aws_subnet" "web_subnet_2" {
  cidr_block = "10.10.1.128/25"
  vpc_id = "${aws_vpc.Bancroft_Group.id}"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-1b"

tags {
  Name = "WEB_SUBNET_2"
}
}



########## Sophos Firewall #########################
resource "aws_subnet" "sophos_int_subnet_1" {
  cidr_block = "10.10.2.0/25"
  vpc_id = "${aws_vpc.Bancroft_Group.id}"

  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "false"



  tags {
    Name = "SOPHOS_INT_SUBNET_1"
  }

}

resource "aws_subnet" "sophos_int_subnet_2" {

  cidr_block = "10.10.2.128/25"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "false"
  vpc_id = "${aws_vpc.Bancroft_Group.id}"

  tags {
    Name = "SOPHOS_INT_SUBNET_2"
  }
}


############ Data Subnets #####################
resource "aws_subnet" "data_subnet_1" {
  cidr_block = "10.10.4.0/25"
  map_public_ip_on_launch = "false"
  vpc_id = "${aws_vpc.Bancroft_Group.id}"
  availability_zone = "us-east-1a"
  tags {
    Name = "DATA_SUBNET_1"
  }
}


resource "aws_subnet" "data_subnet_2" {
  cidr_block = "10.10.4.128/25"
  vpc_id = "${aws_vpc.Bancroft_Group.id}"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "false"
  tags {
    Name = "DATA_SUBNET_2"
  }
}



########## Managment Subnets ##################
resource "aws_subnet" "mgmt_subnet_1" {
  cidr_block = "10.10.3.0/25"
  vpc_id = "${aws_vpc.Bancroft_Group.id}"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "false"
  tags {
    Name = "MGMT_SUBNET_1"
  }
}

resource "aws_subnet" "mgmt_subnet_2" {
  cidr_block = "10.10.3.128/25"
  vpc_id = "${aws_vpc.Bancroft_Group.id}"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "false"
  tags {
    Name = "mgmt_subnet_2"
  }
}


############# Elastic Search Logstach  Kibana #########

resource "aws_subnet" "elk_Subnet_1" {
  cidr_block = "10.10.6.0/25"
  vpc_id = "${aws_vpc.Bancroft_Group.id}"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "false"
  tags {
    Name = "ELK SUBNET 1"
  }
}


################################################
############## Nat Gateway ######################3

