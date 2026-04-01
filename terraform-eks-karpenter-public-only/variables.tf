variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "environment" {
  description = "Environment name (dev/staging/prod)"
  type        = string
  default     = "dev"
}

# =========================
# VPC CONFIG
# =========================

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_count" {
  description = "Number of public subnets"
  type        = number
  default     = 2
}

# =========================
# EKS CONFIG
# =========================

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.33"
}

# =========================
# NODE GROUP CONFIG
# =========================

variable "node_instance_types" {
  description = "Instance types for node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_desired_size" {
  type    = number
  default = 2
}

variable "node_min_size" {
  type    = number
  default = 1
}

variable "node_max_size" {
  type    = number
  default = 3
}

# =========================
# KARPENTER CONFIG
# =========================

variable "karpenter_queue_name" {
  description = "SQS queue name for Karpenter interruption handling"
  type        = string
}

# =========================
# COMMON TAGS
# =========================

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default = {
    Project     = "eks-karpenter"
    ManagedBy   = "terraform"
  }
}