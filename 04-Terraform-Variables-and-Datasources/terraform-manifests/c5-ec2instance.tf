resource "aws_network_interface" "myec2vm" {
  subnet_id       = aws_subnet.public_a.id
  private_ips     = ["10.1.1.100"]
  security_groups = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]

  tags = {
    Name = "primary_network_interface"
  }
}

# EC2 Instance
resource "aws_instance" "myec2vm" {
  ami           = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  user_data     = file("${path.module}/app1-install.sh")
  key_name      = var.instance_keypair

  tags = {
    "Name" = "EC2 Demo 2"
  }

  network_interface {
    network_interface_id = aws_network_interface.myec2vm.id
    device_index         = 0
  }
}
