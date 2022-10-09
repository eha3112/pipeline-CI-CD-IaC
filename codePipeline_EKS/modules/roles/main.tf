
# CodePipeline
resource "aws_iam_role" "codepipeline_role" {
  name = var.role_codepipeline_name

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "codepipeline.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
  })
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = var.policy_codepipeline_name
  role = aws_iam_role.codepipeline_role.id

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:GetObject",
            "s3:GetObjectVersion",
            "s3:GetBucketVersioning",
            "s3:PutObjectAcl",
            "s3:PutObject"
          ],
          "Resource" : [
            "arn:aws:s3:::${var.bucket_source_codepipeline_name}",
            "arn:aws:s3:::${var.bucket_source_codepipeline_name}/*",
            "arn:aws:s3:::${var.bucket_codepipeline_artifacts_name}",
            "arn:aws:s3:::${var.bucket_codepipeline_artifacts_name}/*",
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "codebuild:BatchGetBuilds",
            "codebuild:StartBuild"
          ],
          "Resource" : "*"
        },

        {
          "Sid" : "CodeStarConnectionsReadWriteAccess",
          "Effect" : "Allow",
          "Action" : [
            "codestar-connections:CreateConnection",
            "codestar-connections:DeleteConnection",
            "codestar-connections:UpdateConnectionInstallation",
            "codestar-connections:TagResource",
            "codestar-connections:UntagResource",
            "codestar-connections:ListConnections",
            "codestar-connections:ListInstallationTargets",
            "codestar-connections:ListTagsForResource",
            "codestar-connections:GetConnection",
            "codestar-connections:GetIndividualAccessToken",
            "codestar-connections:GetInstallationUrl",
            "codestar-connections:PassConnection",
            "codestar-connections:StartOAuthHandshake",
            "codestar-connections:UseConnection"
          ],
          "Resource" : "arn:aws:codestar-connections:*:*:connection/*"
        },
      ]
  })
}


# codebuild
resource "aws_iam_role" "codebuild_role" {
  name = var.role_codebuild_name

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "codebuild.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"

        }
      ]
    }
  )
}


resource "aws_iam_role_policy" "build_app_policy" {
  name = var.policy_codebuild_name
  role = aws_iam_role.codebuild_role.name
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : [
            "codebuild:*",
            "codecommit:GetBranch",
            "codecommit:GetCommit",
            "codecommit:GetRepository",
            "codecommit:ListBranches",
            "codecommit:ListRepositories",
            "ec2:DescribeVpcs",
            "ec2:DescribeSecurityGroups",
            "ec2:DescribeSubnets",
            "ecr:DescribeRepositories",
            "ecr:ListImages",
            "elasticfilesystem:DescribeFileSystems",
            "events:DeleteRule",
            "events:DescribeRule",
            "events:DisableRule",
            "events:EnableRule",
            "events:ListTargetsByRule",
            "events:ListRuleNamesByTarget",
            "events:PutRule",
            "events:PutTargets",
            "events:RemoveTargets",
            "logs:GetLogEvents",
          ],
          "Effect" : "Allow",
          "Resource" : "*"
        },
        {
          "Action" : [
            "logs:DeleteLogGroup"
          ],
          "Effect" : "Allow",
          "Resource" : "arn:aws:logs:*:*:log-group:/aws/codebuild/*:log-stream:*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "ssm:PutParameter"
          ],
          "Resource" : "arn:aws:ssm:*:*:parameter/CodeBuild/*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "ssm:StartSession"
          ],
          "Resource" : "arn:aws:ecs:*:*:task/*/*"
        },
        {
          "Sid" : "CodeStarConnectionsReadWriteAccess",
          "Effect" : "Allow",
          "Action" : [
            "codestar-connections:CreateConnection",
            "codestar-connections:DeleteConnection",
            "codestar-connections:UpdateConnectionInstallation",
            "codestar-connections:TagResource",
            "codestar-connections:UntagResource",
            "codestar-connections:ListConnections",
            "codestar-connections:ListInstallationTargets",
            "codestar-connections:ListTagsForResource",
            "codestar-connections:GetConnection",
            "codestar-connections:GetIndividualAccessToken",
            "codestar-connections:GetInstallationUrl",
            "codestar-connections:PassConnection",
            "codestar-connections:StartOAuthHandshake",
            "codestar-connections:UseConnection"
          ],
          "Resource" : "arn:aws:codestar-connections:*:*:connection/*"
        },
        {
          "Sid" : "CodeStarNotificationsReadWriteAccess",
          "Effect" : "Allow",
          "Action" : [
            "codestar-notifications:CreateNotificationRule",
            "codestar-notifications:DescribeNotificationRule",
            "codestar-notifications:UpdateNotificationRule",
            "codestar-notifications:DeleteNotificationRule",
            "codestar-notifications:Subscribe",
            "codestar-notifications:Unsubscribe"
          ],
          "Resource" : "*",
          "Condition" : {
            "StringLike" : {
              "codestar-notifications:NotificationsForResource" : "arn:aws:codebuild:*"
            }
          }
        },
        {
          "Sid" : "CodeStarNotificationsListAccess",
          "Effect" : "Allow",
          "Action" : [
            "codestar-notifications:ListNotificationRules",
            "codestar-notifications:ListEventTypes",
            "codestar-notifications:ListTargets",
            "codestar-notifications:ListTagsforResource"
          ],
          "Resource" : "*"
        },
        {
          "Sid" : "CodeStarNotificationsSNSTopicCreateAccess",
          "Effect" : "Allow",
          "Action" : [
            "sns:CreateTopic",
            "sns:SetTopicAttributes"
          ],
          "Resource" : "arn:aws:sns:*:*:codestar-notifications*"
        },
        {
          "Sid" : "SNSTopicListAccess",
          "Effect" : "Allow",
          "Action" : [
            "sns:ListTopics",
            "sns:GetTopicAttributes"
          ],
          "Resource" : "*"
        },
        {
          "Sid" : "CodeStarNotificationsChatbotAccess",
          "Effect" : "Allow",
          "Action" : [
            "chatbot:DescribeSlackChannelConfigurations"
          ],
          "Resource" : "*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:*",
            "s3-object-lambda:*"
          ],
          "Resource" : "*"
        },
        {
          "Action" : [
            "autoscaling:Describe*",
            "cloudwatch:*",
            "logs:*",
            "sns:*",
            "iam:GetPolicy",
            "iam:GetPolicyVersion",
            "iam:GetRole",
            "iam:DeletePolicyVersion",
          ],
          "Effect" : "Allow",
          "Resource" : "*"
        },
        {
          "Effect" : "Allow",
          "Action" : "iam:CreateServiceLinkedRole",
          "Resource" : "arn:aws:iam::*:role/aws-service-role/events.amazonaws.com/AWSServiceRoleForCloudWatchEvents*",
          "Condition" : {
            "StringLike" : {
              "iam:AWSServiceName" : "events.amazonaws.com"
            }
          }
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "ecr:GetAuthorizationToken",
            "ecr:BatchGetImage",
            "ecr:BatchCheckLayerAvailability",
            "ecr:CompleteLayerUpload",
            "ecr:DescribeImages",
            "ecr:DescribeRepositories",
            "ecr:GetDownloadUrlForLayer",
            "ecr:InitiateLayerUpload",
            "ecr:ListImages",
            "ecr:PutImage",
            "ecr:UploadLayerPart"

          ],
          "Resource" : "*"
        },
        {
          "Sid" : "EKSREADONLY",
          "Effect" : "Allow",
          "Action" : [
            "eks:DescribeNodegroup",
            "eks:DescribeUpdate",
            "eks:DescribeCluster"
          ],
          "Resource" : "*"
        }
      ]
    }
  )
}


/*
resource "aws_iam_role_policy" "build_app_policy" {
  name = var.policy_codebuild_name
  role = aws_iam_role.codebuild_role.name

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Resource" : [
            "*"
          ],
          "Action" : [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "ec2:CreateNetworkInterface",
            "ec2:DescribeDhcpOptions",
            "ec2:DescribeNetworkInterfaces",
            "ec2:DeleteNetworkInterface",
            "ec2:DescribeSubnets",
            "ec2:DescribeSecurityGroups",
            "ec2:DescribeVpcs"
          ],
          "Resource" : "*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:*"
          ],
          "Resource" : [
            "arn:aws:s3:::${var.bucket_codepipeline_artifacts_name}",
            "arn:aws:s3:::${var.bucket_codepipeline_artifacts_name}/*",
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "imagebuilder:GetComponent",
            "imagebuilder:GetContainerRecipe",
            "ecr:GetAuthorizationToken",
            "ecr:BatchGetImage",
            "ecr:InitiateLayerUpload",
            "ecr:UploadLayerPart",
            "ecr:CompleteLayerUpload",
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetDownloadUrlForLayer",
            "ecr:PutImage"
          ],
          "Resource" : "*"
        },
        {
          "Effect" : "Allow",
          "Action" : "eks:*"
          "Resource" : "*"
          # [
          #        "eks:DescribeNodegroup",
          #        "eks:DescribeUpdate",
          #        "eks:DescribeCluster",
          #],



        }

      ]
    }
  )
}

*/



