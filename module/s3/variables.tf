variable "general_config" {
  type = map(any)
}
variable "bucket_role" {}
variable "index_document" {}
variable "cloudfront_origin_access_identity_iam_arn" {}