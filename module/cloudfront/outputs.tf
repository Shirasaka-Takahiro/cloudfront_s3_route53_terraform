output "distribution_arn" {
  value = aws_cloudfront_distribution.default.arn
}

output "distribution_hosted_zone_id" {
  value = aws_cloudfront_distribution.default.hosted_zone_id
}

output "distribution_domain_name" {
  value = aws_cloudfront_distribution.default.domain_name
}