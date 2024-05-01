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

resource "aws_iam_openid_connect_provider" "default" {
  url = "${var.cluster_oidc_url}"
  client_id_list = [
    "sts.amazonaws.com",
  ]
  thumbprint_list = ["${var.thumbprint_list}"]
}