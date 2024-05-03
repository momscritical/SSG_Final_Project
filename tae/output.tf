# 클러스터의 엔드포인트 정보 출력
output "cluster_endpoint" {
  value = module.final_eks.cluster_endpoint
}

# kubectl 명령어를 사용하여 클러스터에 연결하는 데 필요한 인증 기관 데이터 출력
output "kubeconfig-certificate-authority-data" {
  value = module.final_eks.kubeconfig-certificate-authority-data
}

output "cluster_oidc_url" {
  value = module.final_eks.oidc
}

output "cluster_id" {
  value = module.final_eks.cluster_id
}

# # 클러스터 토큰 값 출력
# output "cluster_token" {
#   value = module.final_eks.cluster_token
# }

# # output "web_asg_name" {
# #   value = module.final_eks.web_asg_name
# # }

# # output "was_asg_name" {
# #   value = module.final_eks.was_asg_name
# # }

# output "int_lb_dns" {
#   value = module.final_lb.int_dns_name
# }