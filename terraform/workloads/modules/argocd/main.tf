

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  namespace  = "argocd"

  depends_on = [kubernetes_namespace.argocd]
}

resource "kubernetes_manifest" "argocd_ingress" {
  manifest = {
    apiVersion = "networking.k8s.io/v1"
    kind       = "Ingress"
    metadata = {
      name      = "argocd-ingress"
      namespace = "argocd"
      annotations = {
        "alb.ingress.kubernetes.io/scheme"                    = "internet-facing"
        "alb.ingress.kubernetes.io/target-type"               = "ip"
        "alb.ingress.kubernetes.io/listen-ports"              = "[{\"HTTPS\":443}]"
        "alb.ingress.kubernetes.io/backend-protocol"          = "HTTPS"
        "alb.ingress.kubernetes.io/ssl-redirect"              = "443"
        "alb.ingress.kubernetes.io/healthcheck-path"          = "/"
        "alb.ingress.kubernetes.io/healthcheck-port"          = "443"
        "alb.ingress.kubernetes.io/load-balancer-attributes"  = "idle_timeout.timeout_seconds=60"
        "alb.ingress.kubernetes.io/group.name"                = var.ingress_group_name
      }
    }
    spec = {
      ingressClassName = "alb"
      tls = [{
        hosts = ["argocd.${var.domain_name}"]
      }]
      rules = [{
        host = "argocd.${var.domain_name}"
        http = {
          paths = [{
            path     = "/"
            pathType = "Prefix"
            backend = {
              service = {
                name = "argocd-server"
                port = {
                  number = 443
                }
              }
            }
          }]
        }
      }]
    }
  }

  depends_on = [helm_release.argocd, kubernetes_namespace.argocd]
}



# Wait until the ALB is available
resource "null_resource" "wait_for_alb" {
  provisioner "local-exec" {
    command = <<EOT
    for i in {1..20}; do
      result=$(aws elbv2 describe-load-balancers --region us-east-1 --query "LoadBalancers[].LoadBalancerArn" --output text)
      for arn in $result; do
        tag_value=$(aws elbv2 describe-tags --resource-arns $arn --region us-east-1 --query "TagDescriptions[0].Tags[?Key=='ingress.k8s.aws/stack'].Value | [0]" --output text)
        if [ "$tag_value" = "${var.ingress_group_name}" ]; then
          echo "ALB found with tag: $tag_value"
          exit 0
        fi
      done
      echo "Waiting for ALB to be created..."
      sleep 15
    done
    echo "Timed out waiting for ALB" && exit 1
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

  depends_on = [ kubernetes_manifest.argocd_ingress ]
}

data "aws_lb" "argocd_alb" {

  tags = {
    "ingress.k8s.aws/stack" = "${var.ingress_group_name}"
  }

  depends_on = [ null_resource.wait_for_alb ]
}


resource "aws_route53_record" "argocd" {
  zone_id = var.zone_id
  name    = "argocd.${var.domain_name}"
  type    = "A"

  alias {
    name                   = data.aws_lb.argocd_alb.dns_name
    zone_id                = data.aws_lb.argocd_alb.zone_id
    evaluate_target_health = true
  }
  depends_on = [ data.aws_lb.argocd_alb ]
}
