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

# 테스트 중...
# ################################### IAM Role ###################################
# data "aws_iam_policy_document" "oidc" {
#   statement {
#     effect  = "Allow"

#     principals {
#       type        = "Federated"
#       identifiers = [aws_iam_openid_connect_provider.oidc.arn]
#     }

#     actions = ["sts:AssumeRoleWithWebIdentity"]

#     condition {
#       test     = "StringEquals"
#       variable = "${aws_iam_openid_connect_provider.oidc.url}:aud"
#       values   = ["sts.amazonaws.com"]
#     }

#     condition {
#       test     = "StringEquals"
#       variable = "${aws_iam_openid_connect_provider.oidc.url}:sub"
#       values   = ["system:serviceaccount:dev:s3-sa"]
#     }
#   }
# }

# resource "aws_iam_openid_connect_provider" "oidc" {
#   url             = var.cluster_oidc_url
#   thumbprint_list = var.thumbprint_list
#   client_id_list  = [
#     "sts.amazonaws.com",
#   ]
#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_iam_role" "oidc" {
#   description = "AWS IAM role to access AWS S3 for EKS Pods"
#   name               = "s3-full-access-role"
#   assume_role_policy = data.aws_iam_policy_document.oidc.json
# }

# resource "aws_iam_role_policy_attachment" "policy_attachment" {
#   role       = aws_iam_role.oidc.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
# }






# data "aws_iam_policy_document" "oidc" {
#   statement {
#     actions = ["s3:*","s3-object-lambda:*"]
#     # 부여되는 권한의 목록을 지정 => AmazonS3FullAccess 권한 부여

#     effect = "Allow"
#     # EKS 클러스터에게 권한을 부여

#     principals {
#       # 권한을 부여받는 대상
#       type        = ""
#       # "Service"로 설정되어 EKS 서비스만 이 권한을 사용할 수 있도록 설정 
#       identifiers = ["eks.amazonaws.com"]
#       # 권한을 부여받는 서비스의 ARN 목록을 지정
#     }
#   }
# }

# # 클러스터가 IAM 권한을 가지고 사용할 역할
# resource "aws_iam_role" "oidc" {
#   description = "AWS IAM role to access AWS S3 for EKS Pods"
#   name = var.oidc_role_name
#   assume_role_policy = data.aws_iam_policy_document.oidc.json
  
#   lifecycle {
#     create_before_destroy = true
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