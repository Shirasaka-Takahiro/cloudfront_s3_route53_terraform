variable "general_config" {
  type = map(any)
}
variable "bucket_id" {}
variable "cf_cname" {}
variable "index_document" {}
variable "bucket_regional_domain_name" {}
variable "cert_cloudfront_arn" {}
variable "module_acm_cloudfront" {}
variable "bucket_role" {}