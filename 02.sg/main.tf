locals {
  vpc_id = data.aws_ssm_parameter.vpc_id.value
}

module "bastion" {
  source         = "git::https://github.com/ullagallu123/sg.git?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  name           = "bastion"
  vpc_id         = local.vpc_id
  sg_description = "This Sg was used for bastion"
  common_tags    = var.common_tags
}

module "vpn" {
  source         = "git::https://github.com/ullagallu123/sg.git?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  name           = "vpn"
  vpc_id         = local.vpc_id
  sg_description = "This SG was used for vpn"
  common_tags    = var.common_tags
}

module "mysql" {
  source         = "git::https://github.com/ullagallu123/sg.git?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  name           = "mysql"
  vpc_id         = local.vpc_id
  sg_description = "This SG was used for mysql"
  common_tags    = var.common_tags
}
module "mongo" {
  source         = "git::https://github.com/ullagallu123/sg.git?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  name           = "mongo"
  vpc_id         = local.vpc_id
  sg_description = "This SG was used for mongo"
  common_tags    = var.common_tags
}

module "redis" {
  source         = "git::https://github.com/ullagallu123/sg.git?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  name           = "redis"
  vpc_id         = local.vpc_id
  sg_description = "This SG was used for redis"
  common_tags    = var.common_tags
}
module "rabbit" {
  source         = "git::https://github.com/ullagallu123/sg.git?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  name           = "rabbit"
  vpc_id         = local.vpc_id
  sg_description = "This SG was used for rabbit"
  common_tags    = var.common_tags
}

module "catalogue" {
  source         = "git::https://github.com/ullagallu123/sg.git?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  name           = "catalogue"
  vpc_id         = local.vpc_id
  sg_description = "This SG was used for catalogue"
  common_tags    = var.common_tags
}

module "cart" {
  source         = "git::https://github.com/ullagallu123/sg.git?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  name           = "cart"
  vpc_id         = local.vpc_id
  sg_description = "This SG was used for cart"
  common_tags    = var.common_tags
}

module "user" {
  source         = "git::https://github.com/ullagallu123/sg.git?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  name           = "user"
  vpc_id         = local.vpc_id
  sg_description = "This SG was used for user"
  common_tags    = var.common_tags
}

module "shipping" {
  source         = "git::https://github.com/ullagallu123/sg.git?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  name           = "shipping"
  vpc_id         = local.vpc_id
  sg_description = "This SG was used for shipping"
  common_tags    = var.common_tags
}

module "payment" {
  source         = "git::https://github.com/ullagallu123/sg.git?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  name           = "payment"
  vpc_id         = local.vpc_id
  sg_description = "This SG was used for payment"
  common_tags    = var.common_tags
}

module "frontend" {
  source         = "git::https://github.com/ullagallu123/sg.git?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  name           = "frontend"
  vpc_id         = local.vpc_id
  sg_description = "This SG was used for frontend"
  common_tags    = var.common_tags
}
module "alb" {
  source         = "git::https://github.com/ullagallu123/sg.git?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  name           = "alb"
  vpc_id         = local.vpc_id
  sg_description = "This SG was used for alb"
  common_tags    = var.common_tags
}

# Catalogue connects to MongoDB
resource "aws_security_group_rule" "catalogue_to_mongo" {
  description              = "Catalogue connects to MongoDB on 27017"
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  source_security_group_id = module.catalogue.sg_id
  security_group_id        = module.mongo.sg_id
}

# User connects to MongoDB (port 27017) and Redis (port 6379)
resource "aws_security_group_rule" "user_to_mongo" {
  description              = "User connects to MongoDB on 27017"
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  source_security_group_id = module.user.sg_id
  security_group_id        = module.mongo.sg_id
}

resource "aws_security_group_rule" "user_to_redis" {
  description              = "User connects to Redis on 6379"
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = module.user.sg_id
  security_group_id        = module.redis.sg_id
}

# Cart connects to Catalogue (port 8080) and Redis (port 6379)

resource "aws_security_group_rule" "cart_to_catalogue" {
  description              = "Cart connects to Catalogue on 8080"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.cart.sg_id
  security_group_id        = module.catalogue.sg_id
}

resource "aws_security_group_rule" "cart_to_redis" {
  description              = "Cart connects to Redis on 6379"
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = module.cart.sg_id
  security_group_id        = module.redis.sg_id
}

# Shipping connects to MySQL (port 3306) and Cart (port 8080)

resource "aws_security_group_rule" "shipping_to_mysql" {
  description              = "Shipping connects to MySQL on 3306"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.shipping.sg_id
  security_group_id        = module.mysql.sg_id
}

resource "aws_security_group_rule" "shipping_to_cart" {
  description              = "Shipping connects to Cart on 8080"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.shipping.sg_id
  security_group_id        = module.cart.sg_id
}

# Payment connects to Cart (port 8080), User (port 8080), and RabbitMQ (port 5672)

resource "aws_security_group_rule" "payment_to_cart" {
  description              = "Payment connects to Cart on 8080"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.payment.sg_id
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "payment_to_user" {
  description              = "Payment connects to User on 8080"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.payment.sg_id
  security_group_id        = module.user.sg_id
}

resource "aws_security_group_rule" "payment_to_rabbit" {
  description              = "Payment connects to RabbitMQ on 5672"
  type                     = "ingress"
  from_port                = 5672
  to_port                  = 5672
  protocol                 = "tcp"
  source_security_group_id = module.payment.sg_id
  security_group_id        = module.rabbit.sg_id
}

# Frontend connects to multiple services (all port 8080)

resource "aws_security_group_rule" "frontend_to_catalogue" {
  description              = "Frontend connects to Catalogue on 8080"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id        = module.catalogue.sg_id
}

resource "aws_security_group_rule" "frontend_to_cart" {
  description              = "Frontend connects to Cart on 8080"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "frontend_to_user" {
  description              = "Frontend connects to User on 8080"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id        = module.user.sg_id
}

resource "aws_security_group_rule" "frontend_to_shipping" {
  description              = "Frontend connects to Shipping on 8080"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id        = module.shipping.sg_id
}

resource "aws_security_group_rule" "frontend_to_payment" {
  description              = "Frontend connects to Payment on 8080"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id        = module.payment.sg_id
}

# ALB connects to Frontend (port 80)
resource "aws_security_group_rule" "alb_to_frontend" {
  description              = "ALB connects to Frontend on port 80"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.alb.sg_id
  security_group_id        = module.frontend.sg_id
}

# ALB accepts traffic on ports 80 and 443 from the internet
resource "aws_security_group_rule" "alb_http_from_internet" {
  description       = "ALB accepts HTTP (80) traffic from the internet"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.alb.sg_id
}

resource "aws_security_group_rule" "alb_https_from_internet" {
  description       = "ALB accepts HTTPS (443) traffic from the internet"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.alb.sg_id
}

# Bastion
resource "aws_security_group_rule" "bastion_ssh" {
  description       = "This rule allows all traffic from internet on 22"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

# VPN
resource "aws_security_group_rule" "vpn_ssh" {
  description       = "This rule allows all traffic from internet on 22"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "vpn_https" {
  description       = "This rule allows all traffic from internet on 443"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "vpn_internet" {
  description       = "This rule allows all traffic from internet on 992"
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "vpn_udp" {
  description       = "This rule allows all traffic from internet on 1194"
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}
