resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "my_vpc_name"
  }
}

resource "aws_internet_gateway" "my-ig" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "main"
  }
}


resource "aws_subnet" "my-public-subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  
  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "my-private-subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "private-subnet-1"
  }
}


resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-ig.id
  }

  
  tags = {
    Name = "example"
  }
}

resource "aws_route_table_association" "route-association" {
  subnet_id = aws_subnet.my-public-subnet.id
  route_table_id = aws_route_table.my-rt.id
 
}
