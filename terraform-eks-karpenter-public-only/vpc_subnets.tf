# =========================================
# PUBLIC SUBNETS (ONLY)
# =========================================
data "aws_availability_zones" "available" {}

resource "aws_subnet" "public" {
  count = var.public_subnet_count

  vpc_id                  = aws_vpc.main.id

# splits VPC CIDR into /24 subnets for each public subnet by adding 8 bits to the mask
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index) 

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.cluster_name}-public-${count.index}"

    # Required for ALB
    "kubernetes.io/role/elb" = "1"

    # Required for EKS
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  })
}