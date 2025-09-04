
variable "newrelic_license_key" {
  description = "Your New Relic account license key"
  type        = string
  sensitive   = true
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "ksm_image_version" {
  description = "Kube-state-metrics image version"
  type        = string
  default     = "v2.13.0"
}
