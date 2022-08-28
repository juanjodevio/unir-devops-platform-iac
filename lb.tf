data "aws_acm_certificate" "cert" {
  domain   = "www.juanjodev.io"
  statuses = ["ISSUED"]
}

module "alb" {
  source              = "./modules/alb"
  name                = var.name
  vpc_id              = module.vpc.id
  subnets             = module.vpc.public_subnets
  environment         = var.environment
  alb_security_groups = [module.security_groups.alb]
  alb_tls_cert_arn    = data.aws_acm_certificate.cert.arn
  health_check_path   = var.health_check_path
}