resource "aws_eks_cluster" "EKS-TEST" {
  name     = "EKS-TEST"
  role_arn = aws_iam_role.EKS-TESTC.arn

  vpc_config {
    subnet_ids = [aws_subnet.private_subnets[0].id, aws_subnet.private_subnets[1].id]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.EKS-TESTC-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.EKS-TESTC-AmazonEKSVPCResourceController,
  ]
}

output "endpoint" {
  value = aws_eks_cluster.EKS-TEST.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.EKS-TEST.certificate_authority[0].data
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

resource "aws_iam_role" "EKS-TESTC" {
  name               = "eks-cluster-EKS-TESTC"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "EKS-TESTC-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.EKS-TESTC.name
}


resource "aws_iam_role_policy_attachment" "EKS-TESTC-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.EKS-TESTC.name
}

resource "aws_eks_addon" "coredns" {
  cluster_name                = aws_eks_cluster.EKS-TEST.name
  addon_name                  = "coredns"
  addon_version               = "v1.11.1-eksbuild.4" #e.g., previous version v1.9.3-eksbuild.3 and the new version is v1.10.1-eksbuild.1
  resolve_conflicts_on_update = "PRESERVE"
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name                = aws_eks_cluster.EKS-TEST.name
  addon_name                  = "kube-proxy"
  addon_version               = "v1.29.0-eksbuild.1" # You can replace this with the version you need
  resolve_conflicts_on_update = "PRESERVE"
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name                = aws_eks_cluster.EKS-TEST.name
  addon_name                  = "vpc-cni"
  addon_version               = "v1.16.0-eksbuild.1" # You can replace this with the version you need
  resolve_conflicts_on_update = "PRESERVE"
}

