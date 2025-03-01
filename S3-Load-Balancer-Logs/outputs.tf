output "aws_instance_public_dns" {
  value       = "Load Balancer - http://${aws_lb.max_global_lb.dns_name}"
  description = "Public DNS hostname for the Load Balancer"
}
