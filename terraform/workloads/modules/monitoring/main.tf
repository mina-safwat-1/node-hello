

resource "helm_release" "newrelic_bundle" {
  name             = "newrelic-bundle"
  repository       = "https://helm-charts.newrelic.com"
  chart            = "nri-bundle"
  namespace        = "newrelic"
  create_namespace = true

  set {
    name  = "global.licenseKey"
    value = var.newrelic_license_key
  }

  set {
    name  = "global.cluster"
    value = var.cluster_name
  }

  set {
    name  = "global.lowDataMode"
    value = "true"
  }

  set {
    name  = "kube-state-metrics.image.tag"
    value = var.ksm_image_version
  }

  set {
    name  = "kube-state-metrics.enabled"
    value = "true"
  }

  set {
    name  = "kubeEvents.enabled"
    value = "true"
  }

  set {
    name  = "newrelic-prometheus-agent.enabled"
    value = "true"
  }

  set {
    name  = "newrelic-prometheus-agent.lowDataMode"
    value = "true"
  }

  set {
    name  = "newrelic-prometheus-agent.config.kubernetes.integrations_filter.enabled"
    value = "false"
  }

  set {
    name  = "k8s-agents-operator.enabled"
    value = "true"
  }

  set {
    name  = "logging.enabled"
    value = "true"
  }

  set {
    name  = "newrelic-logging.lowDataMode"
    value = "true"
  }
}




# Apply your custom YAML file after Helm chart is installed
resource "kubernetes_manifest" "custom_yaml" {
  manifest = yamldecode(file("${path.module}/instrumentation.yaml"))

  depends_on = [helm_release.newrelic_bundle]
}