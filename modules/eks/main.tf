resource "aws_eks_cluster" "final" {
  name     = "was"
  role_arn = aws_iam_role.was.arn

  vpc_config {
    subnet_ids = [aws_subnet.was-subnet1.id, aws_subnet.was-subnet2.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.final-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.final-AmazonEKSVPCResourceController,
    aws_cloudwatch_log_group.was
  ]

}

output "endpoint" {
  value = aws_eks_cluster.was.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.was.certificate_authority[0].data
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "was" {
  name               = "eks-cluster-was"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.was.name
}

# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
resource "aws_iam_role_policy_attachment" "example-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.was.name
}

resource "aws_cloudwatch_log_group" "was" {
  # The log group name format is /aws/eks/<cluster-name>/cluster
  # Reference: https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
  name              = "/aws/eks/was/cluster"
  retention_in_days = 7

  # ... potentially other configuration ...
}
data "tls_certificate" "was" {
  url = aws_eks_cluster.was.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "was" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.was.certificates[0].sha1_fingerprint]
  url             = data.tls_certificate.was.url
}



resource "aws_eks_node_group" "was" {
  cluster_name    = aws_eks_cluster.was.name
  node_group_name = "was_nodeGroup"
  node_role_arn   = aws_iam_role.was-node.arn
  subnet_ids      = [ aws_subnet.was-subnet1.id ,aws_subnet.was-subnet2.id]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  ]
}


resource "aws_iam_role" "was-node" {
  name = "eks-node-group-was-node"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.was-node.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.was-node.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.was-node.name
}

#nodegroup.tf