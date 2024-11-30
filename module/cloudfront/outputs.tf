output "distribution_hosted_zone_id" {
  value = aws_cloudfront_distribution.default.hosted_zone_id
}

output "distribution_domain_name" {
  value = aws_cloudfront_distribution.default.domain_name
}

output "cloudfront_origin_access_identity_iam_arn" {
  value = aws_cloudfront_origin_access_identity.default_identity.iam_arn
}