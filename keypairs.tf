
resource "aws_key_pair" "linux1" {
  key_name = "linux1"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}