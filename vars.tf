variable "AWS_REGION" {
  default = "us-east-1"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "linux1"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "linux1.pub"
}
variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-97785bed"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-844e0bf7"
    #us-east-1 = "Amazon Linux"
    # us-east-1 = ami-25bd2743 new Cent0S
  }
}
