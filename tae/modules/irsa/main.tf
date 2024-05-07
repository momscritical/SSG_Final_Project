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
data "tls_certificate" "cluster_issuer" {
  url = var.cluster_oidc_url
}

resource "aws_iam_openid_connect_provider" "oidc" {
  url             = data.tls_certificate.cluster_issuer.url
  thumbprint_list = [data.tls_certificate.cluster_issuer.certificates[0].sha1_fingerprint]
  client_id_list  = [
    "sts.amazonaws.com",
  ]

  lifecycle {
    create_before_destroy = true
  }
}

################################### IAM Policy Document ###################################
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

  depends_on = [ aws_iam_openid_connect_provider.oidc ]
}

######################### Create IAM Role to access AWS S3 for EKS Pods #########################
resource "aws_iam_role" "oidc" {
  description = "AWS IAM role to access AWS S3 for EKS Pods"
  name               = var.oidc_role_name
  assume_role_policy = data.aws_iam_policy_document.oidc.json

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [ data.aws_iam_policy_document.oidc ]
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.oidc.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"

  depends_on = [ aws_iam_role.oidc ]
}