resource "null_resource" "modify_file" {
  provisioner "local-exec" {
    command = "sed -i 's/INT_LB_DNS/${var.int_lb_dns}/g' ./yaml/before_nginx.conf"
  }
}

resource "null_resource" "modify_file" {
  provisioner "local-exec" {
    command = "cp ./yaml/before_nginx.conf > ./yaml/nginx.conf"
  }
}