locals {
  container_environment = {
    "LOG_LEVEL" : "DEBUG",
    "DJANGO_SUPERUSER_USERNAME" = "admin",
    "DJANGO_SUPERUSER_PASSWORD" = random_password.django_superuser_password.result,
    "DJANGO_SUPERUSER_EMAIL"    = "juanpalomino@gmail.com",
    "MEDEX_APP_USER"            = module.rds.username,
    "MEDEX_APP_PASSWD"          = module.rds.password,
    "MEDEX_APP_DB"              = module.rds.db_name,
    "MEDEX_APP_DB_HOST"         = module.rds.address,
    "MEDEX_APP_DB_PORT"         = module.rds.port,
    "SECRET_KEY"                = random_password.django_secret_key.result,
    "DEBUG"                     = 0
  }
}

# data "aws_ecr_image" "medex" {
#   repository_name = "juanjodevio/unir-devops-medex-app"
# }

module "ecs" {
  depends_on = [
    module.vpc,
    module.alb,
    module.security_groups,
    module.secrets,
    module.rds
  ]
  source                      = "./modules/ecs"
  name                        = var.name
  environment                 = var.environment
  region                      = var.aws-region
  subnets                     = module.vpc.private_subnets
  aws_alb_target_group_arn    = module.alb.aws_alb_target_group_arn
  ecs_service_security_groups = [module.security_groups.ecs_tasks]
  container_port              = var.container_port
  container_cpu               = var.container_cpu
  container_memory            = var.container_memory
  service_desired_count       = var.service_desired_count
  container_environment = [
    for k, v in local.container_environment : { name = k, value = v }
  ]
  container_image   = "508632573795.dkr.ecr.us-east-1.amazonaws.com/juanjodevio/unir-devops-medex-app"
  container_tag     = local.unir-devops-medex-app.version
  container_secrets = module.secrets.secrets_map
  #   aws_ecr_repository_url = "508632573795.dkr.ecr.us-east-1.amazonaws.com/juanjodevio/unir-devops-medex-app"
  #   container_secrets_arns = module.secrets.application_secrets_arn
}