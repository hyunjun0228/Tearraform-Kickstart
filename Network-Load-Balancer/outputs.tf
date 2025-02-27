output "aws_instance_public_dns" {
  value       = "Instance 1 - http://${aws_instance.taco_instance_1.public_dns}\nInstance 2 - http://${aws_instance.taco_instance_2.public_dns}\nLoad Balancer - http://${aws_lb.nginx_lb.dns_name}"
  description = "Public DNS hostname for the EC2 instance and Load Balancer"
}
