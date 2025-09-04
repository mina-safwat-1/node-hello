variable "Public_Subnets_Count" {
    description = "number of public subnets to create"
    type        = number
    default     = 3
}

variable "private_Subnet_Count" {
    description = "number of private subnets to create"
    type        = number
    default     = 3
}