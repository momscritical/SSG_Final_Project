# EKS Cluster ########################################################
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

# # EKS 클러스터의 기능을 확장하기 위한 애드온설정
# # 코어 DNS(coredns), kube-proxy, VPC CNI 등 필수 애드온과 사용자 정의 애드온
# # 클러스터에서 도메인 이름을 IP 주소로 변환하는 서비스
# 콘솔 화면에서 보면, 기본값이므로 굳이 추가 안 해줘도 되는 듯 하다
# resource "aws_eks_addon" "coredns" {
#   cluster_name                = aws_eks_cluster.cluster.name
#   addon_name                  = "coredns"
#   addon_version               = "v1.11.1-eksbuild.4"
#   resolve_conflicts_on_update = "PRESERVE"
# }
# # 서비스에 대한 트래픽 라우팅을 담당하는 서비스
# resource "aws_eks_addon" "kube_proxy" {
#   cluster_name                = aws_eks_cluster.cluster.name
#   addon_name                  = "kube-proxy"
#   addon_version               = "v1.29.0-eksbuild.1"
#   resolve_conflicts_on_update = "PRESERVE"
# }
# # 클러스터의 Pod가 VPC 네트워킹을 사용하도록 설정하는 플러그
# resource "aws_eks_addon" "vpc_cni" {
#   cluster_name                = aws_eks_cluster.cluster.name
#   addon_name                  = "vpc-cni"
#   addon_version               = "v1.16.0-eksbuild.1"
#   resolve_conflicts_on_update = "PRESERVE"
# }

# 클러스터 생성
resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster.arn

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

# 클러스터의 엔드포인트 정보 출력
output "cluster_endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}

# kubectl 명령어를 사용하여 클러스터에 연결하는 데 필요한 인증 기관 데이터 출력
output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.cluster.certificate_authority[0].data
}

# EKS Node Group ########################################################
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
}

# node_group Role에 청책 추가
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
# Web Node Group
resource "aws_eks_node_group" "web" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = var.web_node_group_name
  node_role_arn   = aws_iam_role.node_group.arn
  subnet_ids      = var.web_node_group_subnet_ids

  scaling_config {
    desired_size = var.web_node_group_desired_size
    max_size     = var.web_node_group_max_size
    min_size     = var.web_node_group_min_size
  }

  update_config {
    max_unavailable = var.web_max_unavailable
    # 업데이트 중 사용할 수 없는 노드의 최대 수를 제한 => 클러스터의 가용성을 유지하면서 노드 그룹 업데이트
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_group_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_group_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_group_AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = {
    Name = var.web_node_group_name
  }
}

# WAS Node Group
resource "aws_eks_node_group" "was" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = var.was_node_group_name
  node_role_arn   = aws_iam_role.node_group.arn
  subnet_ids      = var.was_node_group_subnet_ids

  scaling_config {
    desired_size = var.web_node_group_desired_size
    max_size     = var.web_node_group_max_size
    min_size     = var.web_node_group_min_size
  }

  update_config {
    max_unavailable = 1
  }

  tags = {
    Name = var.was_node_group_name
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_group_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_group_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_group_AmazonEC2ContainerRegistryReadOnly,
  ]
}