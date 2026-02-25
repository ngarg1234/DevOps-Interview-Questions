resource "aws_route53_zone" "private" {
  name = "shyam.com"

  vpc {
    vpc_id = "vpc-9ec776e7"
    #automate it later by using data source or creating seperate vpc
  }
}
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "db.shyam.com"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.db_instance[0].public_ip]
}
