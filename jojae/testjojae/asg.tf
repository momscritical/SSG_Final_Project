data "aws_autoscaling_groups" "web" {
  filter {
    name   = "tag:eks:nodegroup-name"
    values = ["WEB"]
  }
  depends_on = [aws_eks_cluster.EKS-TEST,
    aws_eks_node_group.WEB
  ]

}

data "aws_autoscaling_group" "web" {
  name = data.aws_autoscaling_groups.web.names[0]
  depends_on = [aws_eks_cluster.EKS-TEST,
    aws_eks_node_group.WEB
  ]

}

# 가져온 Autoscaling 그룹의 정보를 사용하여 ELB와 연결
resource "aws_autoscaling_attachment" "asg_attach" {
  autoscaling_group_name = data.aws_autoscaling_group.web.name
  lb_target_group_arn    = aws_lb_target_group.asg_tg.arn
  depends_on = [aws_eks_cluster.EKS-TEST,
    aws_eks_node_group.WEB
  ]
}

data "aws_autoscaling_groups" "was" {
  filter {
    name   = "tag:eks:nodegroup-name"
    values = ["WAS"]
  }
  depends_on = [aws_eks_cluster.EKS-TEST,
    aws_eks_node_group.WAS
  ]

}

data "aws_autoscaling_group" "was" {
  name = data.aws_autoscaling_groups.was.names[0]
  depends_on = [aws_eks_cluster.EKS-TEST,
  aws_eks_node_group.WAS]


}

# 가져온 Autoscaling 그룹의 정보를 사용하여 ELB와 연결
resource "aws_autoscaling_attachment" "asg_was_attach" {
  autoscaling_group_name = data.aws_autoscaling_group.was.name
  lb_target_group_arn    = aws_lb_target_group.internal_asg_tg.arn
  depends_on = [aws_eks_cluster.EKS-TEST,
    aws_eks_node_group.WAS
  ]


}

