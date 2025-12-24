output "ansible-controler_ip" {
  value = aws_instance.ansible-controller.public_ip
}
output "Remote-server1_ip2" {
  value = aws_instance.remote-server1.public_ip
}
output "Remote-server2_ip2" {
  value = aws_instance.remote-server2.public_ip
}
