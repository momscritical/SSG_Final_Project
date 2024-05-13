################################### Amazon Linux AMI ###################################
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

################################### Kubernetes Config ###################################
data "aws_eks_cluster" "final_eks" {
  name = var.cluster_name

  depends_on = [ module.final_eks ]
}
data "aws_eks_cluster_auth" "final_eks" {
  name = var.cluster_name

  depends_on = [ module.final_eks ]
}