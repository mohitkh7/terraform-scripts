data "aws_network_interface" "interface_tags" {
  depends_on = [aws_ecs_service.container]
}

output "public_ip" {
  value = data.aws_network_interface.interface_tags.association[0].public_ip
}