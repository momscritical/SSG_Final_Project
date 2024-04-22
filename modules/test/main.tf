resource "null_resource" "modify_file" {
  provisioner "local-exec" {
    command = "sed 's/INT_LB_DNS/${var.int_lb_dns}/g' ./yaml/before_nginx.conf ./yaml/nginx.conf"
  }
}

# resource "null_resource" "copy_file" {
#   provisioner "local-exec" {
#     command = "cp ./yaml/before_nginx.conf ./yaml/nginx.conf"
#   }
# }

resource "null_resource" "clean_up" {

  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf .nginx.conf"
  }
}