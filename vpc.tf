//------- VPC----------

resource "aws_vpc" "tf_vpc" {
  cidr_block           = var.cidr-block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "tf_vpc"
  }

}

// Internet gateway

resource "aws_internet_gateway" "tf_igw" {
  vpc_id = aws.tf_vpc.id
  tags = {
    Name = "tf_igw"
  }
}

// Nat gateway

resource "aws_eip" "tf_nat" {
  vpc = true
}


resource "aws_nat_gateway" "tf-natgw" {
  allocation_id = aws_eip.tf_nat.id
  subnet_id     = aws_subnet.tf_public1_subnet.id

}

// Route  tables

resource "aws_route_table" "tf_public_rt" {
  vpc_id = aws_vpc.tf_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_igw.id
  }

  tags = {
    Name = "tf_public_rt"
  }
}

resource "aws_default_route_table" "tf_private_rt" {
  default_route_table_id = aws_vpc.tf_vpc.default_route_table_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.tf-natgw.id
  }

  tags = {
    Name = "tf_private_rt"
  }
}

resource "aws_subnet" "tf_public1_subnet" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = var.cidrs["public1"]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "tf_public1_subnet"
  }
}

resource "aws_subnet" "tf_public2_subnet" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = var.cidrs["public2"]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "tf_public2_subnet"
  }
}

resource "aws_subnet" "tf_private1_subnet" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = var.cidrs["private1"]
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "tf_private1_subnet"
  }
}

resource "aws_subnet" "tf_private2_subnet" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = var.cidrs["private2"]
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "tf_private2_subnet"
  }
}

// subnet Association

resource "aws_route_table_association" "tf_public1_assoc" {
  subnet_id      = aws_subnet.tf_public1_subnet.id
  route_table_id = aws_route_table.tf_public_rt.id
}

resource "aws_route_table_association" "tf_public2_assoc" {
  subnet_id      = aws_subnet.tf_public2_subnet.id
  route_table_id = aws_route_table.tf_public_rt.id
}

resource "aws_route_table_association" "tf_private1_assoc" {
  subnet_id      = aws_subnet.tf_private1_subnet.id
  route_table_id = aws_default_route_table.tf_private_rt.id
}

resource "aws_route_table_association" "tf_private2_assoc" {
  subnet_id      = aws_subnet.tf_private2_subnet.id
  route_table_id = aws_default_route_table.tf_private_rt.id
}




