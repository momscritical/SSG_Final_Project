################################### copy_key ###################################
resource "null_resource" "copy_key" {
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = "${file(var.private_key_location)}"
    host = var.bastion_ip
  }

  provisioner "file" {
    source = var.private_key_location
    destination = "${var.private_key_dest}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 ${var.private_key_dest}"
    ]
  }

  provisioner "file" {
    source = "${var.dummy_file_location}"
    destination = "${var.dummy_file_dest}"
  }
}
################################### Copy Dummy Data ###################################
resource "null_resource" "input_dummy_data" {
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = "${file(var.private_key_location)}"
    host = var.bastion_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo scp -i ${var.private_key_dest} -o StrictHostKeyChecking=no ${var.dummy_file_dest} ec2-user@${var.cp_ip}:${var.dummy_file_dest}",
      "sudo ssh -i ${var.private_key_dest} -o StrictHostKeyChecking=no ec2-user@${var.cp_ip} 'sudo mariadb -u ${var.db_user_name} -p'${var.db_user_pass}' -P 3306 -h ${var.rds_address} ${var.db_name} < ${var.dummy_file_dest}'",
      "sudo ssh -i ${var.private_key_dest} -o StrictHostKeyChecking=no ec2-user@${var.cp_ip} 'rm -rf ${var.dummy_file_dest}"
    ]
  }

  depends_on = [null_resource.copy_key]
}