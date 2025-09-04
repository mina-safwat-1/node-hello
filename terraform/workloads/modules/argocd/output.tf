
output "zone_id" {

    value = data.aws_lb.argocd_alb.zone_id
    description = "The zone ID of the ALB created for ArgoCD"
  
}

output "alb_dns_name" {

    value = data.aws_lb.argocd_alb.dns_name
    description = "The DNS name of the ALB created for ArgoCD"
  
}