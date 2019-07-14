variable "vpc_index" {
  description = "Vpc index for cird block"
  default     = "1"
}

variable "project" {
  description = "Project name used for tagging and name resrouces"
}

//ToDo Should pass down this from root module or use data?
variable "availability_zones" {
  type        = list(string)
  description = "availability Zone"
}

variable "instance_tenancy" {
  description = "Dedicated or shared instances"
  type        = string
  default     = "default"
}

variable "az_count" {
  type        = number
  default     = 1
  description = "Number of Availability Zones in the region to use. Should be 1, to Max number of azs in the region"
}
