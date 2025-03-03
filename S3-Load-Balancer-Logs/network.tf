##################################################################################
# DATA
##################################################################################

data "aws_availability_zones" "available" {
  state = "available"
}

##################################################################################
# RESOURCES
##################################################################################

resource "aws_vpc" "app" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames_public_subnet
  enable_dns_support   = true
  tags                 = merge(local.common_tags, { Name = "${local.naming_prefix}-vpc" })
}

resource "aws_internet_gateway" "app" {
  vpc_id = aws_vpc.app.id
}

resource "aws_subnet" "public_subnets" {
  count                   = var.vpc_public_subnet_counts
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, (count.index % var.vpc_public_subnet_counts))
  vpc_id                  = aws_vpc.app.id
  map_public_ip_on_launch = true
  tags                    = merge(local.common_tags, { Name = "${local.naming_prefix}-public-subnet-${count.index}" })
  availability_zone       = data.aws_availability_zones.available.names[(count.index % length(data.aws_availability_zones.available.names))]
}

# ROUTING #
resource "aws_route_table" "app" {
  vpc_id = aws_vpc.app.id

  # Route for internet access via Internet Gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app.id
  }

  tags = merge(local.common_tags, { Name = "${local.naming_prefix}-route-table" })
}

resource "aws_route_table_association" "public_subnets" {
  count          = var.vpc_public_subnet_counts
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.app.id
}

##################################################################################
# Security Policy Management
##################################################################################

### Public security group for EC2 Instance ###
resource "aws_security_group" "public_sg" {
  name   = "public_security_group"
  vpc_id = aws_vpc.app.id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  # Allow inbound HTTPS traffic from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "${local.naming_prefix}-public-sg" })
}

### Public security group for Load Balancer ###
resource "aws_security_group" "alb_sg" {
  name   = "alb_security_group"
  vpc_id = aws_vpc.app.id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound HTTPS traffic from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "${local.naming_prefix}-alb-sg" })
}
