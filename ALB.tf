

/* islb load balancer */
resource "aws_alb" "islb_alb" {
  name            = "QA1-ISLB-ELB"
  internal        = true
  security_groups = ["${aws_security_group.islb_alb_sg.id}"]
  subnets         = ["${var.qa1_subnet_isl_a_id}","${var.qa1_subnet_isl_b_id}"]

  access_logs {
    bucket = "wawa-iac-elb-logs"
    prefix = "q1-islb_alb"
    enabled = true
  }

  idle_timeout = 60

  tags {
    Name = "QA1-ISLB-ALB"
    Environment = "QA1"
  }
}

resource "aws_alb_target_group" "islb_alb_listener_target_group" {
  name     = "islb-alb-listener-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  stickiness {
    type = "lb_cookie"
    cookie_duration = 600
    enabled = true
  }

  health_check {
    interval = 30
    path = "/"
    port = 80
    protocol = "HTTP"
    timeout = 3
    healthy_threshold = 2
    unhealthy_threshold = 2
    /*matcher = 200*/
  }
}

resource "aws_alb_listener" "islb_alb_listener" {
  load_balancer_arn = "${aws_alb.islb_alb.arn}"
  port              = "80"
  protocol          = "HTTP"
  /* Find out the ssl details and change to HTTPS
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"
  */

  default_action {
    target_group_arn = "${aws_alb_target_group.islb_alb_listener_target_group.arn}"
    type             = "forward"
  }
}

resource "aws_security_group" "islb_alb_sg" {
  name        = "islb_alb_sg"
  description = "ISLB alb security group"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "98.110.147.178/32"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [
      "98.110.147.178/32"]
  }
  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  egress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}
