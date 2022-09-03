module "rds" {
  depends_on = [
    module.vpc
  ]
  source = "./modules/rds"

  vpc= module.vpc.id
  instance_class  = "db.t2.micro"
  name            = var.name
  db_name            = "medex_app"
  username        = "medex_app"
  password        = random_password.medex_app_db_password.result
  private_subnets= var.private_subnets_rds
  app_subnets_cidr= var.private_subnets
  availability_zones= var.availability_zones

  environment = var.environment
}