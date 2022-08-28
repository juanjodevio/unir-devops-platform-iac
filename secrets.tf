locals {
  application-secrets = {
    django_secret_key         = random_password.django_secret_key.result
    medex_app_db_password     = random_password.medex_app_db_password.result
    django_superuser_password = random_password.django_superuser_password.result
  }
}

resource "random_password" "django_secret_key" {
  length  = 32
  special = true
  upper   = true
}

resource "random_password" "django_superuser_password" {
  length  = 16
  special = true
  upper   = true
}

resource "random_password" "medex_app_db_password" {
  length  = 32
  special = true
  upper   = true
}

module "secrets" {
  source              = "./modules/secrets"
  name                = var.name
  environment         = var.environment
  application-secrets = local.application-secrets
}
