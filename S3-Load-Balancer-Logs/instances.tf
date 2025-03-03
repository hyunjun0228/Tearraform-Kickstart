##################################################################################
# DATA
##################################################################################

data "aws_ssm_parameter" "amzn2_linux" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

##################################################################################
# RESOURCES
##################################################################################

# EC2 INSTANCES
resource "aws_instance" "max_global_instance" {
  count                  = var.instance_count
  ami                    = nonsensitive(data.aws_ssm_parameter.amzn2_linux.value)
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_subnets[count.index].id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  tags                   = merge(local.common_tags, { Name = "${local.naming_prefix}-instance-${count.index}" })
  iam_instance_profile   = aws_iam_instance_profile.allow_ec2_s3.name
  depends_on             = [aws_iam_role_policy.allow_ec2_s3]

  user_data = templatefile("${path.root}/templates/startup_script.tpl", { s3_bucket_name = "${local.s3_bucket_name}" })
}

# IAM Role
# - Creating a new role for EC2 instance to grant permission to S3
resource "aws_iam_role" "allow_ec2_s3" {
  name = "allow_ec2_s3"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Sid    = "",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(local.common_tags, { Name = "${local.naming_prefix}-ec2" })
}

# IAM Role Policy
# - Grant role access to S3 bucket
resource "aws_iam_role_policy" "allow_ec2_s3" {
  name = "${local.naming_prefix}-allow-ec2-s3"
  role = aws_iam_role.allow_ec2_s3.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
        ],
        Effect = "Allow",
        Resource = [
          "arn:aws:s3:::${local.s3_bucket_name}",
          "arn:aws:s3:::${local.s3_bucket_name}/*"
        ]
      },
    ]
  })
}

# IAM Instance Profile
# - Assign role to EC2 instance
resource "aws_iam_instance_profile" "allow_ec2_s3" {
  name = "allow_ec2_s3_profile"
  role = aws_iam_role.allow_ec2_s3.name

  tags = merge(local.common_tags, { Name = "${local.naming_prefix}-allow-ec2-s3-profile" })
}
