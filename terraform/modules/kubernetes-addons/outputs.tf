output "ingress_nginx_status" {
  description = "Status of Nginx Ingress installation"
  value       = helm_release.nginx_ingress.status
}

output "argocd_status" {
  description = "Status of ArgoCD installation"
  value       = helm_release.argocd.status
}

output "monitoring_status" {
  description = "Status of Datadog/Monitoring installation"
  value       = helm_release.datadog.status
}