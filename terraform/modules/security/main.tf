resource "aws_security_group" "eks_cluster" {
  name        = "${var.name_prefix}-eks-cluster-sg"
  description = "EKS cluster security group"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTPS"

    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-eks-cluster-sg"
    }
  )
}

resource "aws_security_group" "eks_nodes" {
  name        = "${var.name_prefix}-eks-node-sg"
  description = "EKS node security group"
  vpc_id      = var.vpc_id

  ingress {
    description = "Node to node"

    from_port = 0
    to_port   = 65535
    protocol  = "tcp"

    self = true
  }

  ingress {
    description = "Cluster to nodes"

    from_port = 0
    to_port   = 65535
    protocol  = "tcp"

    security_groups = [
      aws_security_group.eks_cluster.id
    ]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-eks-node-sg"
    }
  )
}