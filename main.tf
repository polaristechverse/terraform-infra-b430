provider "aws" {
  region = "us-east-1"
}
resource "aws_vpc" "demovpc" {
  cidr_block           = "10.20.0.0/16"
  enable_dns_hostnames = true
  tags = {
    "Name" = var.vpc_name
  }
}

resource "aws_internet_gateway" "demoigw" {
  vpc_id = aws_vpc.demovpc.id
  tags = {
    "Name" = "Ansible-IGW"
  }
}

resource "aws_subnet" "demopublicsubnet" {
  count                   = length(var.publicsubnet_cidr)
  vpc_id                  = aws_vpc.demovpc.id
  cidr_block              = element(var.publicsubnet_cidr, count.index)
  availability_zone       = element(var.az, count.index)
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.vpc_name}-PublicSubnet-${count.index + 1}"
  }
}

resource "aws_route_table" "demopublicroute" {
  vpc_id = aws_vpc.demovpc.id
  tags = {
    "Name" = "${var.vpc_name}-PublicRTB"
  }
  route {
    gateway_id = aws_internet_gateway.demoigw.id
    cidr_block = "0.0.0.0/0"
  }
}

resource "aws_route_table_association" "demopublicassociation" {
  count          = length(var.publicsubnet_cidr)
  route_table_id = aws_route_table.demopublicroute.id
  subnet_id      = element(aws_subnet.demopublicsubnet.*.id, count.index)
}

resource "aws_security_group" "webserver" {
  vpc_id      = aws_vpc.demovpc.id
  description = "allow web access"
  name        = "webaccess"
  tags = {
    Name = "Webaccess"
  }
  dynamic "ingress" {
    for_each = local.ingress_rules1
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
