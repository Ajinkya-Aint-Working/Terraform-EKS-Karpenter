# =========================================
# EKS CLUSTER SECURITY GROUP
# =========================================
resource "aws_security_group" "eks_cluster" {
  name   = "${var.cluster_name}-eks-cluster-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.cluster_name}-eks-cluster-sg"
  })
}

# =========================================
# NODE SECURITY GROUP
# =========================================
resource "aws_security_group" "node" {
  name   = "${var.cluster_name}-node-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "Allow node to node"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  ingress {
    description = "Allow cluster communication"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = [aws_security_group.eks_cluster.id]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.cluster_name}-node-sg"
  })
}