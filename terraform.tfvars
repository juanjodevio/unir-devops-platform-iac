name               = "unir-devops-medex-app"
environment        = "dev2"
availability_zones = ["us-east-1a", "us-east-1b"]
private_subnets    = ["10.0.0.0/20", "10.0.32.0/20"]
public_subnets     = ["10.0.16.0/20", "10.0.48.0/20"]
private_subnets_rds    = ["10.0.64.0/20", "10.0.80.0/20"]
# tsl_certificate_arn = "mycertificatearn"
container_memory = 512
platform_on=false