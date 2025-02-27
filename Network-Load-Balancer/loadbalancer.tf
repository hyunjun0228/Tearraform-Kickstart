# aws_lb
resource "aws_lb" "nginx_lb" {
  name               = "globo-web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]

  enable_deletion_protection = false

  tags = local.common_tags
}

# aws_lb_target_group_1
resource "aws_lb_target_group" "alb_tg_1" {
  name     = "lb-target-group-1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.app.id

  tags = local.common_tags
}

# aws_lb_listener
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.nginx_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_1.arn
  }

  tags = local.common_tags
}
# aws_lb_target_group_attachment for first instance
resource "aws_lb_target_group_attachment" "taco_instance_1" {
  target_group_arn = aws_lb_target_group.alb_tg_1.arn
  target_id        = aws_instance.taco_instance_1.id
  port             = 80
}

# aws_lb_target_group_attachment for second instance
resource "aws_lb_target_group_attachment" "taco_instance_2" {
  target_group_arn = aws_lb_target_group.alb_tg_1.arn
  target_id        = aws_instance.taco_instance_2.id
  port             = 80
}
