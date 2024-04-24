resource "aws_key_pair" "final_key" {
    key_name   = var.key_name
    public_key = file("${var.public_key_location}")

    tags = {
        Name = var.key_tags
    }
}