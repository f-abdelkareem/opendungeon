output "openvpn_public_ip" {
  value = aws_instance.openvpn_instance.public_ip
}