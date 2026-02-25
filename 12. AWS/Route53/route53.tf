# Provider configuration
provider "aws" {
  region = "us-west-2"  # Specify your AWS region
}

# Create a Route 53 Hosted Zone
resource "aws_route53_zone" "my_zone" {
  name = "example.com"  # Replace with your domain name
}

# A Record - Pointing to an IP address
resource "aws_route53_record" "my_a_record" {
  zone_id = aws_route53_zone.my_zone.id
  name    = "www"              # Subdomain (e.g., www.example.com)
  type    = "A"
  ttl     = 300                # TTL stands for Time to Live               
  records = ["192.0.2.1"]      # Replace with your actual IP address
}

# TTL stands for "Time to Live",  It is a value in seconds that tells DNS resolvers how long they should cache the DNS record before querying the authoritative DNS server for a fresh copy of the record.
# Low TTL (e.g., 300 seconds / 5 minutes), High TTL (e.g., 86400 seconds / 24 hours)

# CNAME Record - Redirect to another domain
resource "aws_route53_record" "my_cname_record" {
  zone_id = aws_route53_zone.my_zone.id
  name    = "blog"              # Subdomain (e.g., blog.example.com)
  type    = "CNAME"
  ttl     = 300
  records = ["example-blog.com"]  # Target domain to point to
}

# MX Record - Mail Exchange
resource "aws_route53_record" "my_mx_record" {
  zone_id = aws_route53_zone.my_zone.id
  name    = "example.com"       # For the root domain
  type    = "MX"
  ttl     = 300
  records = [
    "10 mail1.example.com.",
    "20 mail2.example.com."
  ]
}

# TXT Record - Adding arbitrary text (e.g., for verification purposes)
resource "aws_route53_record" "my_txt_record" {
  zone_id = aws_route53_zone.my_zone.id
  name    = "example.com"
  type    = "TXT"
  ttl     = 300
  records = ["\"v=spf1 include:example.com ~all\""]
}
