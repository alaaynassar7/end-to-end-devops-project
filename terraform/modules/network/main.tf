# --- Virtual Private Cloud (VPC) ---
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(var.tags, { Name = "${var.project_name}-vpc" })
}

# --- Public Subnets ---
# Dynamic creation based on input list length
resource "aws_subnet" "public" {
  count                   = length(var.public_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_cidrs[count.index]
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.project_name}-public-${count.index + 1}"
    "kubernetes.io/role/elb" = "1" # Required for EKS public Load Balancer discovery
  })
}

# --- Private Subnets ---
# Dynamic creation based on input list length
resource "aws_subnet" "private" {
  count             = length(var.private_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_cidrs[count.index]
  availability_zone = element(var.azs, count.index % length(var.azs))

  tags = merge(var.tags, {
    Name = "${var.project_name}-private-${count.index + 1}"
    "kubernetes.io/role/internal-elb" = "1" # Required for EKS internal Load Balancer discovery
  })
}

# --- Internet Gateway ---
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = merge(var.tags, { Name = "${var.project_name}-igw" })
}

# --- NAT Gateway ---
# Single NAT Gateway strategy for cost optimization
resource "aws_eip" "nat" {
  domain = "vpc"
  tags   = merge(var.tags, { Name = "${var.project_name}-nat-eip" })
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id # Placed in the first public subnet
  tags          = merge(var.tags, { Name = "${var.project_name}-nat" })

  depends_on = [aws_internet_gateway.igw]
}

# --- Route Tables ---

# Public Route Table: Routes traffic via Internet Gateway
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(var.tags, { Name = "${var.project_name}-public-rt" })
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Private Route Table: Routes traffic via NAT Gateway
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = merge(var.tags, { Name = "${var.project_name}-private-rt" })
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}