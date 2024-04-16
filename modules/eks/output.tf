# 클러스터의 엔드포인트 정보 출력
output "cluster_endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}

# kubectl 명령어를 사용하여 클러스터에 연결하는 데 필요한 인증 기관 데이터 출력
output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.cluster.certificate_authority[0].data
}

output "web_asg_tag" {
  value = aws_eks_node_group.web.tags["ASG-Tag"]
}

output "was_asg_tag" {
  value = aws_eks_node_group.was.tags["ASG-Tag"]
}

# # 클러스터 토큰 값 출력
# output "cluster_token" {
#   value = aws_eks_cluster.cluster.api_token
# }