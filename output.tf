
# code output
output "instance" {
  value = "${aws_instance.Nginx-1.public_dns}"
}
output "Bastion_Windows" {
  value = "${aws_instance.Bastion_Windows.public_dns}"
}
/*
output "VPN_Sophos-2-INT" {
  value = "${aws_instance.VPN-Sophos-2.public_dns} , ${aws_instance.VPN-Sophos-2.private_ip}"
}

output "VPN_Sophos" {
  value = "${aws_instance.VPN-Sophos.public_dns} , ${aws_instance.VPN-Sophos.private_ip}"

}

*/
