resource "aws_ssm_parameter" "bastion_id" {
  name  = "/${var.project_name}/${var.environment}/bastion-sg-id"
  type  = "String"
  value = module.bastion.sg_id
}

resource "aws_ssm_parameter" "vpn_id" {
  name  = "/${var.project_name}/${var.environment}/vpn-sg-id"
  type  = "String"
  value = module.vpn.sg_id
}

resource "aws_ssm_parameter" "mysql_sg_id" {
  name  = "/${var.project_name}/${var.environment}/mysql-sg-id"
  type  = "String"
  value = module.mysql.sg_id
}

resource "aws_ssm_parameter" "mongo_sg_id" {
  name  = "/${var.project_name}/${var.environment}/mongo-sg-id"
  type  = "String"
  value = module.mongo.sg_id
}

resource "aws_ssm_parameter" "redis_sg_id" {
  name  = "/${var.project_name}/${var.environment}/redis-sg-id"
  type  = "String"
  value = module.redis.sg_id
}

resource "aws_ssm_parameter" "rabbit_sg_id" {
  name  = "/${var.project_name}/${var.environment}/rabbit-sg-id"
  type  = "String"
  value = module.rabbit.sg_id
}

resource "aws_ssm_parameter" "catalogue_sg_id" {
  name  = "/${var.project_name}/${var.environment}/catalogue-sg-id"
  type  = "String"
  value = module.catalogue.sg_id
}

resource "aws_ssm_parameter" "cart_sg_id" {
  name  = "/${var.project_name}/${var.environment}/cart-sg-id"
  type  = "String"
  value = module.cart.sg_id
}

resource "aws_ssm_parameter" "user_sg_id" {
  name  = "/${var.project_name}/${var.environment}/user-sg-id"
  type  = "String"
  value = module.user.sg_id
}

resource "aws_ssm_parameter" "shipping_sg_id" {
  name  = "/${var.project_name}/${var.environment}/shipping-sg-id"
  type  = "String"
  value = module.shipping.sg_id
}

resource "aws_ssm_parameter" "payment_sg_id" {
  name  = "/${var.project_name}/${var.environment}/payment-sg-id"
  type  = "String"
  value = module.payment.sg_id
}

resource "aws_ssm_parameter" "frontend_sg_id" {
  name  = "/${var.project_name}/${var.environment}/frontend-sg-id"
  type  = "String"
  value = module.frontend.sg_id
}

resource "aws_ssm_parameter" "alb_sg_id" {
  name  = "/${var.project_name}/${var.environment}/alb-sg-id"
  type  = "String"
  value = module.alb.sg_id
}
