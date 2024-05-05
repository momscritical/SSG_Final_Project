############################## Add Kubernetes Config to AWS ##############################
resource "null_resource" "install_ingress_ctroller" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${var.yaml_location}"
  }
}

resource "null_resource" "unstall_ingress_ctroller" {
  provisioner "local-exec" {
    when    = destroy
    command = "kubectl delete -f ${var.yaml_location}"
  }
}