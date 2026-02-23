resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.s3_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.s3_bucket.arn}/*"
      } 
    ]
  })
}


resource "aws_s3_object" "index" {
  key        = "index.html"
  bucket     = aws_s3_bucket.s3_bucket.id
  source     = "index.html"
  content_type = "text/html"
}
resource "aws_s3_object" "error" {
  key        = "error.html"
  bucket     = aws_s3_bucket.s3_bucket.id
  source     = "error.html"
  content_type = "text/html"
}

# aws_s3_bucket_website_configuration
# Configures the specified S3 bucket to function as a static website
# 
# This resource sets up:
# - index_document: Specifies "index.html" as the default document to serve
#   when a user accesses the bucket's root or any directory
# - error_document: Specifies "error.html" as the custom error page to display
#   when the user requests a resource that does not exist (4xx errors)
#
# The bucket must already exist (referenced via aws_s3_bucket.s3_bucket.id)
# This configuration enables static website hosting capabilities on the S3 bucket
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.s3_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}