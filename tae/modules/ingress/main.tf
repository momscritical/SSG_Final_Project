provider "kubernetes" {
  host                   = var.cluster_endpoint
  cluster_ca_certificate = var.kubeconfig-certificate-authority-data
  token                  = var.cluster_token
}

# deploy.yaml 파일의 내용을 Terraform으로 정의
resource "kubernetes_manifest" "ingress_nginx_controller" {
  manifest = file("${var.yaml_location}")
}