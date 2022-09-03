module "rds" {
  source = "./modules/rds"

  vpc= module.vpc.id
  instance_class  = "db.t2.micro"
  name            = var.name
  db_name            = "medex_app"
  username        = "medex_app"
  password        = random_password.medex_app_db_password.result
  private_subnets = module.vpc.private_subnets.*.id
  private_subnets_cidr= var.private_subnets

  environment = var.environment
}