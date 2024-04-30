# provider "kubernetes" {
#   host                   = var.cluster_endpoint
#   cluster_ca_certificate = base64decode(var.kubeconfig-certificate-authority-data)
# }

# deploy.yaml 파일의 내용을 Terraform으로 정의
# data "local_file" "ingress_controller" {
#   filename = var.yaml_location
# }

resource "kubernetes_manifest" "ingress_nginx_controller" {
  manifest = yamldecode(file("${var.yaml_location}"))
}

# data "local_file" "ingress_controller" {
#   filename = "${path.module}/deploy.yaml"
# }

# resource "kubernetes_manifest" "ingress_controller" {
#   manifest = yamldecode(data.local_file.ingress_controller.content)
# }

# resource "kubernetes_manifest" "nginx_deployment" {
#   manifest = <<EOF
# apiVersion: apps/v1
# kind: Deployment
# metadata:
#   name: nginx-deployment
# spec:
#   replicas: 3
#   selector:
#     matchLabels:
#       app: nginx
#   template:
#     metadata:
#       labels:
#         app: nginx
#     spec:
#       containers:
#         - name: nginx
#           image: nginx:latest
#           ports:
#             - containerPort: 80
# EOF
# }
