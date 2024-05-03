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
locals {
  oidc            = var.oidc
  split_oidc      = split("/", local.oidc)
  url             = element(local.split_oidc, 2)
  thumbprint_list = element(local.split_oidc, 4)
}

# ######################### Declare Linux Environment Variables for OIDC #########################
# resource "aws_iam_openid_connect_provider" "default" {
#   url = "https://${local.url}"
#   thumbprint_list = [ local.thumbprint_list ]
#   client_id_list = [
#     "sts.amazonaws.com",
#   ]
# }