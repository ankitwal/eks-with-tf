output "pirvate_subnets" {
    value = module.vpc.private-subnet-ids
}

output "public_subnets" {
    value = module.vpc.public-subnet-ids
}