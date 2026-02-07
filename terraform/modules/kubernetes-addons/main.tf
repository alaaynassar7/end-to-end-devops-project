# --- Nginx Ingress Controller ---
# It will automatically create a Classic/Network Load Balancer in AWS
resource "helm_release" "nginx_ingress" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true

  values = [yamlencode({
    controller = {
      service = {
        type = "LoadBalancer"
        annotations = {
          "service.beta.kubernetes.io/aws-load-balancer-type"     = "nlb"
          "service.beta.kubernetes.io/aws-load-balancer-internal" = "true"
        }
      }
    }
  })]
}

# --- Argo CD (Step 5 in your plan) ---
resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
}

# --- Datadog Agent (Step 5 in your plan) ---
resource "helm_release" "datadog" {
  name             = "datadog"
  repository       = "https://helm.datadoghq.com"
  chart            = "datadog"
  namespace        = "monitoring"
  create_namespace = true
}