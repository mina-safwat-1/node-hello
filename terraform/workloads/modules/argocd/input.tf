variable "oidc_provider_arn" {
    description = "OIDC provider ARN"
    type        = string

}


variable "cluster_issuer" {
    description = "Cluster issuer URL"
    type        = string
  
}

variable "cluster_name" {
    description = "EKS cluster name"
    type        = string
  
}

variable "zone_id" {
  description = "The ID of the Route 53 hosted zone."
  type        = string
  
}

variable "region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
  
}

variable "account_id" {
  description = "The AWS account ID."
  type        = string
  
}



variable "sshPrivateKey_path" {
    description = "Path to the SSH private key for accessing the Git repository."
    type        = string
  
}



variable "domain_name" {
    description = "The domain name for Route 53 records."
    type        = string
    default     = "itiproject.site"
  
}


variable "ingress_group_name" {
    description = "The name of the security group for the ALB ingress controller."
    type        = string
    default     = "itiproject-alb"
}