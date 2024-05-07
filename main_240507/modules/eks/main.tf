# ############################## EKS Cluster ##############################
# EKS 클러스터가 IAM 권한을 사용할 수 있게 해주는 정책 문서 생성
# => 클러스터가 필요할 때만 권한을 주고 다시 회수
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    # EKS 클러스터에게 권한을 부여

    principals {
      # 권한을 부여받는 대상
      type        = "Service"
      # "Service"로 설정되어 EKS 서비스만 이 권한을 사용할 수 있도록 설정 
      identifiers = ["eks.amazonaws.com"]
      # 권한을 부여받는 서비스의 ARN 목록을 지정
    }

    actions = ["sts:AssumeRole"]
    # 부여되는 권한의 목록을 지정 => sts:AssumeRole 권한만 부여
  }
}

# 클러스터가 IAM 권한을 가지고 사용할 역할
resource "aws_iam_role" "cluster" {
  name = var.cluster_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  
  lifecycle {
    create_before_destroy = true
  }
}

# cluster Role에 청책 추가
resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}
resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.cluster.name
}

# 클러스터 생성
resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster.arn
  version =  var.k8s_version

  vpc_config {
    subnet_ids = var.cluster_subnet_ids
  }

  tags = {
    Name = var.cluster_name
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSVPCResourceController,
  ]
}

# ############################## EKS Node Group ##############################
# Node Group이 사용할 역할(Role) 생성
resource "aws_iam_role" "node_group" {
  name = var.node_group_role_name

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

  lifecycle {
    create_before_destroy = true
  }
}

# Node Group Role에 청책 추가
resource "aws_iam_role_policy_attachment" "node_group_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_group.name
}
resource "aws_iam_role_policy_attachment" "node_group_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_group.name
}
resource "aws_iam_role_policy_attachment" "node_group_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_group.name
}

# Node Group 생성
# Application Node Group
resource "aws_eks_node_group" "app" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = var.app_node_group_name
  node_role_arn   = aws_iam_role.node_group.arn
  subnet_ids      = var.app_node_group_subnet_ids
  instance_types  = var.app_instance_types

  scaling_config {
    desired_size = var.app_node_group_desired_size
    max_size     = var.app_node_group_max_size
    min_size     = var.app_node_group_min_size
  }

  update_config {
    max_unavailable = var.app_max_unavailable
    # 업데이트 중 사용할 수 없는 노드의 최대 수를 제한 => 클러스터의 가용성을 유지하면서 노드 그룹 업데이트
  }

  taint {
    key     = var.app_taint_key
    value   = var.app_taint_value
    effect  = var.app_taint_effect
  }

  tags = {
    Name          = var.app_node_group_name
    Environment   = var.app_environment
    ASG-Tag       = var.app_asg_tag
  }
  
  depends_on = [
    aws_iam_role_policy_attachment.node_group_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_group_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_group_AmazonEC2ContainerRegistryReadOnly,
  ]
}



# Setting Node Group
resource "aws_eks_node_group" "set" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = var.set_node_group_name
  node_role_arn   = aws_iam_role.node_group.arn
  subnet_ids      = var.set_node_group_subnet_ids
  instance_types  = var.set_instance_types

  scaling_config {
    desired_size = var.set_node_group_desired_size
    max_size     = var.set_node_group_max_size
    min_size     = var.set_node_group_min_size
  }

  update_config {
    max_unavailable = var.set_max_unavailable
  }

  tags = {
    Name = var.set_node_group_name
    Environment   = var.set_environment
    ASG-Tag = var.set_asg_tag
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_group_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_group_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_group_AmazonEC2ContainerRegistryReadOnly,
  ]
}

############################## Update Kubernetes Config ##############################
resource "null_resource" "eks_kubeconfig" {
  provisioner "local-exec" {
    # 명령어 실행
    command = "aws eks --region ${var.region} update-kubeconfig --name ${var.cluster_name}"
  }

  depends_on = [
    aws_eks_cluster.cluster,
    aws_eks_node_group.set,
    aws_eks_node_group.app,
    # aws_eks_node_group.was
  ]
}