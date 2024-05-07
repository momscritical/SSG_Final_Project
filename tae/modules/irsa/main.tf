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
################################### IAM Role ###################################
data "aws_iam_policy_document" "oidc" {
  statement {
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.oidc.arn]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "${aws_iam_openid_connect_provider.oidc.url}:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "${aws_iam_openid_connect_provider.oidc.url}:sub"
      values   = var.service_account_name
    }
  }

  depends_on = [ aws_iam_openid_connect_provider.OIDC ]
}

resource "aws_iam_role" "oidc" {
  description = "AWS IAM role to access AWS S3 for EKS Pods"
  name               = var.oidc_role_name
  assume_role_policy = data.aws_iam_policy_document.oidc.json
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.oidc.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

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