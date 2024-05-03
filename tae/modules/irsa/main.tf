######################### Declare Linux Environment Variables for OIDC #########################
resource "null_resource" "environment_variables" {
  provisioner "lolocal-exec" {
    command = [
        "cluster_name=${var.cluster_name}",
        "oidc_id=$(aws eks describe-cluster --name $cluster_name --query 'cluster.identity.oidc.issuer' --output text | cut -d '/' -f 5)",
        "echo $oidc_id"
    ]
  }
}

######################### Declare Linux Environment Variables for OIDC #########################
resource "aws_iam_openid_connect_provider" "example" {
  url             = var.oidc_url
  thumbprint_list = [var.thumbprint_list]
  client_id_list  = [
    "sts.amazonaws.com",
    ]
}