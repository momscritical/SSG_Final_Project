data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.final_eks.cluster_id
  depends_on = [ module.final_eks ]
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
  depends_on = [ module.final_eks ]
}