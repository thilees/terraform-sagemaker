provider "aws" {
  profile = "arn:aws:iam::058243774065:instance-profile/cmbot-terraform-role"
  region     = "${var.AWS_REGION}"
}
