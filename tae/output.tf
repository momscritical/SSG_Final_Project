# 클러스터의 엔드포인트 정보 출력
output "cluster_endpoint" {
  value = module.final_eks.cluster_endpoint
}

# kubectl 명령어를 사용하여 클러스터에 연결하는 데 필요한 인증 기관 데이터 출력
output "kubeconfig-certificate-authority-data" {
  value = module.final_eks.kubeconfig-certificate-authority-data
}

# WAS Service Account Yaml 정보 수정을 위한 OIDC Role ARN
output "oidc_role_arn" {
  value = module.final_irsa.role_arn
}

# output "cluster_id" {
#   value = module.final_eks.cluster_id
# }