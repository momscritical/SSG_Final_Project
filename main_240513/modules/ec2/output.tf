output "bastion_ip" {
    value = "${aws_instance.bastion.public_ip}"
}

output "cp_ip" {
    value = "${aws_instance.cp.private_ip}"
}