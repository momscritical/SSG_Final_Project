resource "null_resource" "apply_ingress_controller" {
  
  provisioner "local-exec" {
    command = "kubectl apply -f ingress-controller.yaml"
  }
}