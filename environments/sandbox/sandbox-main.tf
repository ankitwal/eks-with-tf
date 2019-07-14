data aws_availability_zones "available" {
}

module "vpc" {
  source             = "../../modules/vpc"
  vpc_index          = 1
  project            = "idn-sandbox-${terraform.workspace}"
  availability_zones = data.aws_availability_zones.available.names
  az_count           = 1
  instance_tenancy   = "${var.instance_tenancy}"


}
