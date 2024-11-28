##Access key
variable "access_key" {
  description = "Access key"
  type        = string
}

##Secret Key
variable "secret_key" {
  description = "Secret Key"
  type        = string
}

##General Config
variable "general_config" {
  type = map(any)
  default = {
    project = "example"
    env     = "dev"
  }
}

##Regions
variable "regions" {
  default = {
    virginia = "us-east-1"
  }
}

##Route53
variable "zone_id" {
  description = "Zone id on Route53"
  type        = string
}

variable "zone_name" {
  description = "Zone name on Route53"
  type        = string
}

##ACM
variable "domain_name" {
  description = "Domain name for ACM"
  type        = string
}

variable "sans" {
  description = "Subject alternative names for ACM"
  type        = string
}

##S3
variable "index_document" {
  description = "Website index document"
  type        = string
}

##CloudFront
variable "cf_cname" {
  description = "cname for CloudFront"
  type        = string
}