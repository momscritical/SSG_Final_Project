resource "null_resource" "modify_file" {
  provisioner "local-exec" {
    command = "sed -i 's/INT_LB_DNS/${var.int_lb_dns}/g' ./yaml/befor_nginx.conf > ./yaml/nginx.conf"
  }
}