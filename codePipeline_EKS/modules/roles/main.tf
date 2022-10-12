
# roles 
resource "aws_iam_role" "codepipeline_role" {
  name = "role-${var.role_codepipeline_name}"
  tags = var.tags
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

resource "aws_iam_role" "codebuild_role" {
  name = "role-${var.role_codebuild_name}"
  tags = var.tags
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


resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "policy-${var.role_codepipeline_name}"
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
            "arn:aws:s3:::${var.bucket_source_code_name}",
            "arn:aws:s3:::${var.bucket_source_code_name}/*",
            "arn:aws:s3:::${var.bucket_artifacts_name}",
            "arn:aws:s3:::${var.bucket_artifacts_name}/*",
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


resource "aws_iam_role_policy" "codebuild_policy" {
  name = "policy-${var.role_codebuild_name}"
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
            "arn:aws:s3:::${var.bucket_artifacts_name}",
            "arn:aws:s3:::${var.bucket_artifacts_name}/*",
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