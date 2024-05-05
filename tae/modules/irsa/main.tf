######################### Declare Linux Environment Variables for OIDC #########################
resource "null_resource" "environment_variables" {
  provisioner "local-exec" {
    command = <<-EOT
      cluster_name="${var.cluster_name}"
      oidc_id="$(aws eks describe-cluster --name ${var.cluster_name} --query 'cluster.identity.oidc.issuer' --output text | cut -d '/' -f 5)"
      echo "$oidc_id"
    EOT
  }
}

######################### Create AWS IAM OpenID Connect Provider #########################
resource "aws_iam_openid_connect_provider" "OIDC" {
  url             = var.cluster_oidc_url
  thumbprint_list = var.thumbprint_list
  client_id_list  = [
    "sts.amazonaws.com",
  ]
  lifecycle {
    create_before_destroy = true
  }
}

# ################################### IAM Role ###################################
# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     effect = "Allow"
#     # EKS 클러스터에게 권한을 부여

#     principals {
#       # 권한을 부여받는 대상
#       type        = "Service"
#       # "Service"로 설정되어 EKS 서비스만 이 권한을 사용할 수 있도록 설정 
#       identifiers = ["eks.amazonaws.com"]
#       # 권한을 부여받는 서비스의 ARN 목록을 지정
#     }

#     actions = ["sts:AssumeRole"]
#     # 부여되는 권한의 목록을 지정 => sts:AssumeRole 권한만 부여
#   }
# }

# # Create IAM Role
# resource "aws_iam_role" "node_group" {
#   name = var.oidc_role_name

#   assume_role_policy = jsonencode({
#     Statement = [{
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = {
#         Service = "ec2.amazonaws.com"
#       }
#     }]
#     Version = "2012-10-17"
#   })

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# # Role에 청책 추가
# resource "aws_iam_role_policy_attachment" "node_group_AmazonEKSWorkerNodePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.node_group.name
# }
# resource "aws_iam_role_policy_attachment" "node_group_AmazonEKS_CNI_Policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#   role       = aws_iam_role.node_group.name
# }
# resource "aws_iam_role_policy_attachment" "node_group_AmazonEC2ContainerRegistryReadOnly" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   role       = aws_iam_role.node_group.name
# }