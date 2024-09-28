output "bastion" {
  value = module.bastion.sg_id
}
output "vpn" {
  value = module.vpn.sg_id
}
output "mysql" {
  value = module.mysql.sg_id
}
output "mongo" {
  value = module.mongo.sg_id
}
output "redis" {
  value = module.redis.sg_id
}
output "rabbit" {
  value = module.rabbit.sg_id
}
output "catalogue" {
  value = module.catalogue.sg_id
}
output "cart" {
  value = module.cart.sg_id
}
output "user" {
  value = module.user.sg_id
}
output "shipping" {
  value = module.shipping.sg_id
}
output "payment" {
  value = module.payment.sg_id
}
output "frontend" {
  value = module.frontend.sg_id
}
output "alb" {
  value = module.alb.sg_id
}