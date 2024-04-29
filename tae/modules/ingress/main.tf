# deploy.yaml 파일의 내용을 Terraform으로 정의
resource "kubernetes_manifest" "ingress_nginx_controller" {
  manifest = yamldecode("${var.yaml_location}")
}

# provider "kubernetes" {
#   # 여기에 Kubernetes 클러스터에 연결하는 데 필요한 설정을 입력하세요.
# }

# data "local_file" "ingress_controller" {
#   filename = "${path.module}/deploy.yaml"
# }

# resource "kubernetes_manifest" "ingress_controller" {
#   manifest = yamldecode(data.local_file.ingress_controller.content)
# }