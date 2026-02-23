#these are all used for outputting the values of the S3 bucket and website configuration after the resources have been created. 
#They allow you to easily access important information about your S3 bucket and static website, such as the bucket name, ARN, and website endpoint, which can be useful for further configuration or for accessing the website once it's deployed.
#simply , to see the website we, use website endpoint 

output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.s3_bucket.bucket
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.s3_bucket.arn
}

output "website_endpoint" {
  description = "S3 static website endpoint"
  value       = aws_s3_bucket_website_configuration.website.website_endpoint
}

output "website_domain" {
  description = "S3 static website domain"
  value       = aws_s3_bucket_website_configuration.website.website_domain
}