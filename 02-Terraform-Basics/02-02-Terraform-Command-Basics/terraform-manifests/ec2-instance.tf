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

resource "aws_instance" "ec2demo" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  tags = merge(
    local.common_tags,
    tomap({
      Name = "${local.prefix}-ec2demo"
    })
  )

  network_interface {
    network_interface_id = aws_network_interface.ec2demo.id
    device_index         = 0
  }
}
