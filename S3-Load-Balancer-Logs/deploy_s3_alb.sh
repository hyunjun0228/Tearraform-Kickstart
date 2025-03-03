# Discover availability zones, subnets, application load balancer, target group, load balancer listener, and target group attachment.
# terraform state list
terraform init
terraform fmt
terraform validate

# Run the export commands for local deployment
# export TF_VAR_AWS_ACCESS_KEY_IDy=YOUR_ACCESS_KEY
# export TF_VAR_AWS_SECRET_ACCESS_KEY=YOUR_SECRET_KEY

terraform plan -out deploy_s3_alb.tfplan
terraform apply deploy_s3_alb.tfplan