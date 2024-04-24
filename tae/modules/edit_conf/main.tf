resource "null_resource" "copy_file" {
  provisioner "local-exec" {
    command = "cp ./yaml/before_nginx.conf ./yaml/nginx.conf"
  }
}

resource "null_resource" "modify_file" {
  provisioner "local-exec" {
    command = "sed -i \"s/INT_LB_DNS/${var.int_lb_dns}/g\" ./yaml/nginx.conf"
  }
  depends_on = [ null_resource.copy_file ]
}

resource "null_resource" "clean_up" {
  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf ./yaml/nginx.conf"
  }
}