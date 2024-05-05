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


######################### Declare Linux Environment Variables for OIDC #########################
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