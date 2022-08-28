
module "ecs" {
  depends_on = [
    module.vpc,
    module.alb,
    module.security_groups,
    module.secrets
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
    { name = "LOG_LEVEL",
    value = "DEBUG" },
    { name = "PORT",
    value = var.container_port }
  ]
  container_image   = "juanjodevio/unir-devops-medex-app"
  container_tag     = local.unir-devops-medex-app.version
  container_secrets = module.secrets.secrets_map
  #   aws_ecr_repository_url = "508632573795.dkr.ecr.us-east-1.amazonaws.com/juanjodevio/unir-devops-medex-app"
  #   container_secrets_arns = module.secrets.application_secrets_arn
}