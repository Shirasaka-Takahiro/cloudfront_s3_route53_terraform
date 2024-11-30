##Provider for us-east-1
provider "aws" {
  profile    = "terraform-user"
  alias      = "virginia"
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "us-east-1"
}

##S3
module "s3" {
  source = "../../module/s3"

  general_config = var.general_config
  bucket_role = var.bucket_role
  index_document = var.index_document
  cloudfront_origin_access_identity_iam_arn = module.cloudfront.cloudfront_origin_access_identity_iam_arn
}

##DNS
module "naked_domain" {
  source = "../../module/route53"

  zone_id                     = var.zone_id
  zone_name                   = "quick-infra.net"
  record_type                 = "A"
  distribution_domain_name    = module.cloudfront.distribution_domain_name
  distribution_hosted_zone_id = module.cloudfront.distribution_hosted_zone_id
}

module "sub_domain_1" {
  source = "../../module/route53"

  zone_id                     = var.zone_id
  zone_name                   = "www"
  record_type                 = "A"
  distribution_domain_name    = module.cloudfront.distribution_domain_name
  distribution_hosted_zone_id = module.cloudfront.distribution_hosted_zone_id
}

##ACM
module "acm_cloudfront" {
  source = "../../module/acm"

  zone_id     = var.zone_id
  domain_name = var.domain_name
  sans        = var.sans
}

##CloudFront
module "cloudfront" {
  source = "../../module/cloudfront"

  general_config      = var.general_config
  cf_cname            = var.cf_cname
  #domain_name         = var.domain_name
  bucket_regional_domain_name         = module.s3.bucket_regional_domain_name
  bucket_id           = module.s3.bucket_id
  cert_cloudfront_arn = module.acm_cloudfront.cert_cloudfront_arn
}
