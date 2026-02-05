# --- OIDC Identity Provider ---
# Establishes trust between AWS IAM and the EKS cluster for IRSA
data "tls_certificate" "eks" {
  url = var.oidc_issuer_url
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = var.oidc_issuer_url

  tags = var.tags
}

# --- IAM Role for Ingress Controller (IRSA) ---
# Specific role for the AWS Load Balancer Controller to manage NLBs
resource "aws_iam_role" "ingress_controller" {
  name = "${var.project_name}-ingress-controller-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.eks.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
          }
        }
      }
    ]
  })

  tags = var.tags
}

# Attachment of required policies for the Load Balancer Controller
# Note: You should create the custom policy for the controller and attach its ARN here
resource "aws_iam_role_policy_attachment" "ingress_controller_attach" {
  policy_arn = var.ingress_controller_policy_arn
  role       = aws_iam_role.ingress_controller.name
}