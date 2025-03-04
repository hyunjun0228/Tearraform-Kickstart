##################################################################################
# DATA
##################################################################################

# Service Account for LB
data "aws_elb_service_account" "root" {}

##################################################################################
# RESOURCES
##################################################################################

# Load Balancer
resource "aws_lb" "max_global_lb" {
  name               = "${local.naming_prefix}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.public_subnets[*].id

  enable_deletion_protection = false

  access_logs {
    bucket  = local.s3_bucket_name
    prefix  = "alb-logs"
    enabled = true
  }

  depends_on = [aws_s3_bucket_policy.allow_access_alb]

  tags = merge(local.common_tags, { Name = "${local.naming_prefix}-lb" })
}

# Load Balancer Target Group
# - Grouping of servers that receive traffic from the LB
resource "aws_lb_target_group" "alb_tg" {
  name     = "${local.naming_prefix}-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.app.id

  tags = merge(local.common_tags, { Name = "${local.naming_prefix}-lb-tg" })
}

# Load Balancer Listener
# - Defines rules on how the LB listens for traffic
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.max_global_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }

  tags = merge(local.common_tags, { Name = "${local.naming_prefix}-lb-listener" })
}

# aws_lb_target_group_attachment for first instance
resource "aws_lb_target_group_attachment" "max_global_instance_1" {
  count            = var.instance_count
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = aws_instance.max_global_instance[count.index].id
  port             = 80
}
