provider "kubernetes" {
  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(var.kubeconfig-certificate-authority-data)
}

# deploy.yaml 파일의 내용을 Terraform으로 정의
data "local_file" "ingress_controller" {
  filename = var.yaml_location
}

resource "kubernetes_manifest" "ingress_nginx_controller" {
  manifest = yamldecode(data.local_file.ingress_controller.content)
}

# data "local_file" "ingress_controller" {
#   filename = "${path.module}/deploy.yaml"
# }

# resource "kubernetes_manifest" "ingress_controller" {
#   manifest = yamldecode(data.local_file.ingress_controller.content)
# }