resource "aws_s3_bucket" "this" {
  bucket = "${random_pet.bucket.id}-${var.environment}"
  tags   = local.common_tags
}

# import resources that it was create manualy
# terraform import ~see documentation
# terraform console ~after import you can verify the bucket
# resource "aws_s3_bucket" "manual" {
#   bucket = "meubucketcriadonoconsoledaaws123123"

#   tags = {
#     Criado    = "14/01/2021"
#     Importado = "23/01/2021"
#     ManagedBy = "Terraform"
#   }
# }

resource "aws_s3_bucket_object" "this" {
  bucket       = aws_s3_bucket.this.bucket
  key          = "config/${local.ip_filepath}"
  source       = local.ip_filepath
  etag         = filemd5(local.ip_filepath)
  content_type = local.content_type

  tags = local.common_tags
}

resource "aws_s3_bucket_object" "random" {
  bucket       = aws_s3_bucket.this.bucket
  key          = "config/${random_pet.bucket.id}.json"
  source       = local.ip_filepath
  etag         = filemd5(local.ip_filepath)
  content_type = local.content_type

  tags = local.common_tags
}
