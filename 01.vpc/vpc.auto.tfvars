environment = "sandbox"

project_name = "instana"

common_tags = {
  Terraform              = true
  Creator                = "SIVARAMAKRISHNA KONKA"
  Project_Name           = "Instana"
  Environment            = "sandbox"
  Module                 = "VPC"
  Deployment_Environment = "ECS"
}

availability_zones = ["ap-south-1a", "ap-south-1b"]

vpc_cidr_block = "10.0.0.0/16"

public_subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]

private_subnet_cidr_blocks = ["10.0.3.0/24", "10.0.4.0/24"]

db_subnet_cidr_blocks = ["10.0.5.0/24", "10.0.6.0/24"]