variable "cluster_name" {

    description = "The name of the EKS cluster"
    type        = string
    default     = "eks-cluster"
  
}


variable "domain_name" {
    description = "The domain name for the load balancer"
    type        = string
    default     = "itiproject.site"
  
}

variable "newrelic_license_key" {
  description = "Your New Relic account license key"
  type        = string
  sensitive   = true
  
}