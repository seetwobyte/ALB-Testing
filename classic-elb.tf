
# External Classic Load balnacer

resource "aws_elb" "Web-elb" {
  name = "web-elb"
  subnets = [
    "${aws_subnet.pub_subnet_1.id}",
    "${aws_subnet.pub_subnet_2.id}"]
  security_groups = ["${aws_security_group.allow_ssh.id}"]
  internal = "false"
  #instances = ["${aws_instance.Nginx-1.id}", "${aws_instance.Nginx-2.id}"]

  /*access_logs {
    bucket = "bancroft_group_s3"
    bucket_prefix = "myelb"
    interval = 60
  } */

  "listener" {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    interval = 15
    target = "http:80/"
    timeout = 3
    unhealthy_threshold = 2
  }
  cross_zone_load_balancing = "true"
  connection_draining = "true"
  connection_draining_timeout = 400
  tags {
    Name = "Web-elb"
  }

  }

