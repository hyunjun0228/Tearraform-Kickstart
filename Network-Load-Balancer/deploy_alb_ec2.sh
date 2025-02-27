# Discover availability zones, subnets, application load balancer, target group, load balancer listener, and target group attachment.
# terraform state list
# terraform state show aws_instance.taco_instance_1
terraform init
terraform fmt
terraform validate

# Run the export commands for local deployment
# export TF_VAR_aws_access_key=YOUR_ACCESS_KEY
# export TF_VAR_aws_secret_key=YOUR_SECRET_KEY

terraform plan -out deploy_alb_ec2.tfplan
terraform apply deploy_alb_ec2.tfplan