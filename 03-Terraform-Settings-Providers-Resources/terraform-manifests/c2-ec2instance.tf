data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }
  owners = ["amazon"]
}

resource "aws_network_interface" "ec2demo" {
  subnet_id   = aws_subnet.public_a.id
  private_ips = ["10.1.1.100"]

  tags = {
    Name = "primary_network_interface"
  }
}

# Resource: EC2 Instance
resource "aws_instance" "myec2vm" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  user_data     = file("${path.module}/app1-install.sh")
  tags = {
    "Name" = "EC2 Demo"
  }

  network_interface {
    network_interface_id = aws_network_interface.ec2demo.id
    device_index         = 0
  }
}