data "aws_caller_identity" "current" {}

#Role for the notbook instance
resource "aws_iam_role" "ni_role" {
  name = "cmbot_ni_role"
  path = "/"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role.json}"
  tags = local.common_tags
   
  depends_on = ["aws_s3_bucket.s3bucket"]
}

##Assume role data
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = [ "sts:AssumeRole" ]
    principals {
      type = "Service"
      identifiers = [ "sagemaker.amazonaws.com" ]
    }
  }
}

resource "aws_iam_policy" "ni_policy" {
  name = "cmbot_ni_policy"
  description = "Allow Sagemaker to create model"
  policy = "${data.aws_iam_policy_document.ni_model_policy.json}"
}

data "aws_iam_policy_document" "ni_model_policy" {
  statement {
    effect = "Allow"
    actions = [
      "sagemaker:*"
    ]
    resources = [
      "*"
    ]
  }  
  statement {
    effect = "Allow"
    actions = [
      "iam:GetRole",
      "iam:PassRole"
    ]
    resources = [
      "arn:aws:iam::058243774065:role/cmbot_ni_role"
    ]
  }
  statement {
   effect = "Allow"
   actions = [
     "ecr:GetDownloadUrlForLayer",
     "ecr:BatchGetImage",
     "ecr:BatchCheckLayerAvailability"
      ]
      resources = [
        "arn:aws:ecr::058243774065:repository/*"
       ]
  }
  statement {
    effect = "Allow"
    actions = [
      "ec2:CreateVpcEndpoint",
      "ec2:DescribeRouteTables"
    ]
    resources = [ "*"
    ]
  }  
  statement {
   effect = "Allow"
   actions = [
      "cloudwatch:PutMetricData",
      "cloudwatch:GetMetricData",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics"
    ]
    resources = [
      "arn:aws:cloudwatch::058243774065:*"
    ]
  }  
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogStreams",
      "logs:GetLogEvents",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs::058243774065:log-group:/aws/sagemaker/*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:PutMetricData",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:CreateLogGroup",
      "logs:DescribeLogStreams",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage"
    ]
    resources = [
      "*"]
  }
  statement {
    effect = "Allow"
    actions = [
        "sagemaker:CreatePresignedDomainUrl",
        "sagemaker:DescribeDomain",
        "sagemaker:ListDomains",
        "sagemaker:DescribeUserProfile",
        "sagemaker:ListUserProfiles",
        "sagemaker:*App",
        "sagemaker:ListApps"
    ]
    resources =  ["*"]
}
statement {
    effect =  "Allow"
    actions =  [
        "application-autoscaling:DeleteScalingPolicy",
        "application-autoscaling:DeleteScheduledAction",
        "application-autoscaling:DeregisterScalableTarget",
        "application-autoscaling:DescribeScalableTargets",
        "application-autoscaling:DescribeScalingActivities",
        "application-autoscaling:DescribeScalingPolicies",
        "application-autoscaling:DescribeScheduledActions",
        "application-autoscaling:PutScalingPolicy",
        "application-autoscaling:PutScheduledAction",
        "application-autoscaling:RegisterScalableTarget",
        "aws-marketplace:ViewSubscriptions",
        "cloudwatch:DeleteAlarms",
        "cloudwatch:DescribeAlarms",
        "cloudwatch:GetMetricData",
        "cloudwatch:GetMetricStatistics",
        "cloudwatch:ListMetrics",
        "cloudwatch:PutMetricAlarm",
        "cloudwatch:PutMetricData",
        "codecommit:BatchGetRepositories",
        "codecommit:CreateRepository",
        "codecommit:GetRepository",
        "codecommit:List*",
        "cognito-idp:AdminAddUserToGroup",
        "cognito-idp:AdminCreateUser",
        "cognito-idp:AdminDeleteUser",
        "cognito-idp:AdminDisableUser",
        "cognito-idp:AdminEnableUser",
        "cognito-idp:AdminRemoveUserFromGroup",
        "cognito-idp:CreateGroup",
        "cognito-idp:CreateUserPool",
        "cognito-idp:CreateUserPoolClient",
        "cognito-idp:CreateUserPoolDomain",
        "cognito-idp:DescribeUserPool",
        "cognito-idp:DescribeUserPoolClient",
        "cognito-idp:List*",
        "cognito-idp:UpdateUserPool",
        "cognito-idp:UpdateUserPoolClient",
        "ec2:CreateNetworkInterface",
        "ec2:CreateNetworkInterfacePermission",
        "ec2:CreateVpcEndpoint",
        "ec2:DeleteNetworkInterface",
        "ec2:DeleteNetworkInterfacePermission",
        "ec2:DescribeDhcpOptions",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DescribeRouteTables",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSubnets",
        "ec2:DescribeVpcEndpoints",
        "ec2:DescribeVpcs",
        "ecr:BatchCheckLayerAvailability",
        "ecr:BatchGetImage",
        "ecr:CreateRepository",
        "ecr:Describe*",
        "ecr:GetAuthorizationToken",
        "ecr:GetDownloadUrlForLayer",
        "ecr:StartImageScan",
        "elastic-inference:Connect",
        "elasticfilesystem:DescribeFileSystems",
        "elasticfilesystem:DescribeMountTargets",
        "fsx:DescribeFileSystems",
        "glue:CreateJob",
        "glue:DeleteJob",
        "glue:GetJob",
        "glue:GetJobRun",
        "glue:GetJobRuns",
        "glue:GetJobs",
        "glue:ResetJobBookmark",
        "glue:StartJobRun",
        "glue:UpdateJob",
        "groundtruthlabeling:*",
        "iam:ListRoles",
        "kms:DescribeKey",
        "kms:ListAliases",
        "lambda:ListFunctions",
        "logs:CreateLogDelivery",
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:DeleteLogDelivery",
        "logs:Describe*",
        "logs:GetLogDelivery",
        "logs:GetLogEvents",
        "logs:ListLogDeliveries",
        "logs:PutLogEvents",
        "logs:PutResourcePolicy",
        "logs:UpdateLogDelivery",
        "robomaker:CreateSimulationApplication",
        "robomaker:DescribeSimulationApplication",
        "robomaker:DeleteSimulationApplication",
        "robomaker:CreateSimulationJob",
        "robomaker:DescribeSimulationJob",
        "robomaker:CancelSimulationJob",
        "secretsmanager:ListSecrets",
        "sns:ListTopics"
    ]
            resources =  ["*"]
}

statement {
    effect =  "Allow"
    actions =  [
        "ecr:SetRepositoryPolicy",
        "ecr:CompleteLayerUpload",
        "ecr:BatchDeleteImage",
        "ecr:UploadLayerPart",
        "ecr:DeleteRepositoryPolicy",
        "ecr:InitiateLayerUpload",
        "ecr:DeleteRepository",
        "ecr:PutImage"
        ]
    resources = [ "arn:aws:ecr::${data.aws_caller_identity.current.account_id}:repository/*" 
    ]
}

statement {
    effect =  "Allow"
    actions =  [
        "codecommit:GitPull",
        "codecommit:GitPush"
    ]
    resources =  [
        "arn:aws:codecommit:*:*:*sagemaker*",
        "arn:aws:codecommit:*:*:*SageMaker*",
        "arn:aws:codecommit:*:*:*Sagemaker*"
    ]
}
  statement {
    effect = "Allow"
    actions = [
      "s3:GetBucketLocation",
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.s3bucket.bucket}",
      "arn:aws:s3:::${aws_s3_bucket.s3bucket.bucket}/*"
    ]
  }
}

resource "aws_iam_role_policy_attachment" "cmbot_ni_policy_attachment" {
  role = "${aws_iam_role.ni_role.name}"
  policy_arn = "${aws_iam_policy.ni_policy.arn}"
}

resource "aws_iam_role" "iam_for_lambda_cmbot" {
  name = "iam_for_lambda_cmbot"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
   tags = local.common_tags
}

resource "aws_iam_policy" "cmbot_lamda_prediction_policy" {
  name = "cmbot_lamda_prediction_policy"
  description = "Allow lamda to revoke sagemaker model endpoint"
  policy = "${data.aws_iam_policy_document.cmbot_lamda_prediction_policy_doc.json}"
}

data "aws_iam_policy_document" "cmbot_lamda_prediction_policy_doc" {
    statement {
    effect = "Allow"
    actions = [
      "sagemaker:InvokeEndpoint"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "cmbot_lamda_prediction_policy_attachment" {
  role = "${aws_iam_role.iam_for_lambda_cmbot.name}"
  policy_arn = "${aws_iam_policy.cmbot_lamda_prediction_policy.arn}"
}
