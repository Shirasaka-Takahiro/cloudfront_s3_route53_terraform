##Cloudfront
resource "aws_cloudfront_distribution" "default" {
  enabled = true
  aliases = [
    var.cf_cname
  ]

  origin {
    domain_name              = var.bucket_regional_domain_name
    origin_id                = var.bucket_id
    origin_access_control_id = aws_cloudfront_origin_access_control.default_oac.id
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = var.cert_cloudfront_arn
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }

  price_class = "PriceClass_All"
  default_root_object = var.index_document

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  default_cache_behavior {  
    allowed_methods  = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
    cached_methods   = ["HEAD", "GET", "OPTIONS"]
    target_origin_id = var.bucket_id

    viewer_protocol_policy     = "redirect-to-https"
    min_ttl                    = 0
    default_ttl                = 10
    max_ttl                    = 60
    cache_policy_id  = data.aws_cloudfront_cache_policy.default.id
    origin_request_policy_id   = data.aws_cloudfront_origin_request_policy.default.id
    response_headers_policy_id = data.aws_cloudfront_response_headers_policy.default.id
  }

  depends_on = [
    var.module_acm_cloudfront
  ]
}

##OAC
resource "aws_cloudfront_origin_access_control" "default_oac" {
  name                              = "${var.general_config["project"]}-${var.general_config["env"]}-${var.bucket_role}-bucket-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

## Managed Origin Request Policy
data "aws_cloudfront_origin_request_policy" "default" {
  name = "Managed-CORS-S3Origin"
}

## Managed Response Header Policy
data "aws_cloudfront_response_headers_policy" "default" {
  name = "Managed-SimpleCORS"
}

## Managed Cache Policy
data "aws_cloudfront_cache_policy" "default" {
  name = "Managed-CachingDisabled"
}