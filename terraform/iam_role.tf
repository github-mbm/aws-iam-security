# Generate unique suffix
resource "random_id" "suffix" {
  byte_length = 2
}

# IAM Role
resource "aws_iam_role" "ec2_role" {
  name = "ec2-secure-role-${random_id.suffix.hex}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# Attach SSM Policy
resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}

# Attach Secrets Manager Policy
resource "aws_iam_role_policy_attachment" "secrets" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

# Instance Profile (also dynamic)
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-profile-${random_id.suffix.hex}"
  role = aws_iam_role.ec2_role.name
}