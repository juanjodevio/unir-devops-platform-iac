locals {
  application-secrets = {
    django_secret_key  = random_password.django_secret_key.result
    medex_app_db       = "medex_app_db"
    medex_app_db_user  = "medex_app"
    medex_app_db_password = random_password.medex_app_db_password.result
  }
}

resource "random_password" "django_secret_key" {
  length  = 32
  special = true
  upper   = true
}

resource "random_password" "medex_app_db_password" {
  length  = 32
  special = true
  upper   = true
}

