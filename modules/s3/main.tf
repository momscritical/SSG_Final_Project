resource "aws_iam_role" "s3" {
  name = var.s3_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_s3_bucket" "s3" {
  bucket = var.s3_name
  acl = 
}

# aws_s3_bucket => 이미지 등 정적 데이터 용?
# aws_s3_directory_bucket => 로그 용?