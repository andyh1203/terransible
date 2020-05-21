resource "aws_iam_instance_profile" "s3_access_profile" {
  name = var.s3_access_profile_name
  role = aws_iam_role.s3_access_role.name
}

data "aws_iam_policy_document" "s3_access_policy" {
  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_role_policy" "s3_access_policy" {
  name   = var.s3_access_policy_name
  role   = aws_iam_role.s3_access_role.id
  policy = data.aws_iam_policy_document.s3_access_policy.json
}

data "aws_iam_policy_document" "s3_access_role" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "s3_access_role" {
  name               = var.s3_access_role_name
  assume_role_policy = data.aws_iam_policy_document.s3_access_role.json
}