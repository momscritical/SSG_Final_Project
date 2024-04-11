resource "aws_eks_node_group" "WEB" {
  cluster_name    = aws_eks_cluster.EKS-TEST.name
  node_group_name = "WEB"
  node_role_arn   = aws_iam_role.EKS-TEST.arn
  subnet_ids      = [
			aws_subnet.private_subnets[0].id,
		    	aws_subnet.private_subnets[1].id
]

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
    aws_iam_role_policy_attachment.EKS-TEST-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.EKS-TEST-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.EKS-TEST-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_eks_node_group" "WAS" {
  cluster_name    = aws_eks_cluster.EKS-TEST.name
  node_group_name = "WAS"
  node_role_arn   = aws_iam_role.EKS-TEST.arn
  subnet_ids      = [
                        aws_subnet.private_subnets[2].id,
                        aws_subnet.private_subnets[3].id
]

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
    aws_iam_role_policy_attachment.EKS-TEST-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.EKS-TEST-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.EKS-TEST-AmazonEC2ContainerRegistryReadOnly,
  ]
}


resource "aws_iam_role" "EKS-TEST" {
  name = "eks-node-group-EKS-TEST"

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

resource "aws_iam_role_policy_attachment" "EKS-TEST-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.EKS-TEST.name
}

resource "aws_iam_role_policy_attachment" "EKS-TEST-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.EKS-TEST.name
}

resource "aws_iam_role_policy_attachment" "EKS-TEST-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.EKS-TEST.name
}
