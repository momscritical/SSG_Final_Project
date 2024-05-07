############################## Add Kubernetes Config to AWS ##############################
resource "null_resource" "install_ingress_ctroller" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${var.yaml_location}"
  }
}