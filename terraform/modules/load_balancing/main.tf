# --- Network Load Balancer ---
resource "aws_lb" "main" {
  name               = "${var.project_name}-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.public_subnets

  enable_deletion_protection = false

  tags = {
    Name = "${var.project_name}-nlb"
  }
}

# --- Target Group for HTTP (Port 80) ---
resource "aws_lb_target_group" "http" {
  name     = "${var.project_name}-http-tg"
  port     = 80
  protocol = "TCP"
  vpc_id   = var.vpc_id
  target_type = "ip" # Required for integration with Nginx Ingress in EKS

  health_check {
    enabled             = true
    protocol            = "TCP"
    interval            = 30
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

# --- Target Group for HTTPS (Port 443) ---
resource "aws_lb_target_group" "https" {
  name     = "${var.project_name}-https-tg"
  port     = 443
  protocol = "TCP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    protocol            = "TCP"
    interval            = 30
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

# --- Listeners ---
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http.arn
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = 443
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.https.arn
  }
}