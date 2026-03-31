resource "aws_instance" "demoinstance" {
  count                       = 6
  ami                         = var.ami
  key_name                    = var.key
  instance_type               = var.type
  subnet_id                   = element(aws_subnet.demopublicsubnet.*.id, count.index)
  vpc_security_group_ids      = [aws_security_group.webserver.id]
  associate_public_ip_address = true
  tags = {
    "Name" = "${var.vpc_name}-Docker-Server"
  }
}
