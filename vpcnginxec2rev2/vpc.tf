resource "aws_vpc" "my-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "my-vpc"

  }
}

resource "aws_internet_gateway" "my-ig" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "main"
  }
}

# Subnets 
resource "aws_subnet" "my-private-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "private-subnet"
  }
}

resource "aws_subnet" "my-public-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.2.0/24"

 
  tags = {
    Name = "public-subnet"
  }
}

# Route table and association 
resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my-vpc.id

   route {
    cidr_block = "0.0.0.0/0"   # Allow all outbound traffic to the internet
    gateway_id = aws_internet_gateway.my-ig.id  # Route through IG for public access
  }


  tags = {
    Name = "my-route-table"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.my-public-subnet.id
  route_table_id = aws_route_table.my-rt.id
}

# Security group 
resource "aws_security_group" "my-ec2-sg" {
  name        = "my-ec2-sg"
  description = "Allow HTTP and SSH"
  vpc_id = aws_vpc.my-vpc.id

  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (make sure to secure SSH access)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "my-security-group"
  }
}

