
### This is for VPC-cni PLUGIN ################################

resource "aws_iam_role" "this_AmazonEKSVPCCNIRole" {
  name = "${var.cluster_name}-${var.env}-AmazonEKSVPCCNIRole"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.this_oidc_provider.arn}"
        },
        "Condition" : {
          "StringEquals" : {
            "${local.aws_iam_oidc_connect_provider_extract_from_arn}:sub" : "system:serviceaccount:kube-system:aws-node"
          }
        }
      }
    ]
  })
  tags = {
    "Name" = "${var.cluster_name}-${var.env}-AmazonEKSVPCCNIRole"
  }
}


resource "aws_iam_role_policy_attachment" "this_AmazonEKSVPCCNIRole_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.this_AmazonEKSVPCCNIRole.name
}


################################################


################  EBS-CSI Driver Role ##################################

resource "aws_iam_role" "this_AmazonEKS_EBS_CSI_DriverRole" {
  name = "${var.cluster_name}-${var.env}-AmazonEKS_EBS_CSI_DriverRole"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.this_oidc_provider.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${local.aws_iam_oidc_connect_provider_extract_from_arn}:aud" : "sts.amazonaws.com",
            "${local.aws_iam_oidc_connect_provider_extract_from_arn}:sub" : "system:serviceaccount:kube-system:ebs-csi-controller-sa"
          }
        }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "this_AmazonEKS_EBS_CSI_DriverRole_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.this_AmazonEKS_EBS_CSI_DriverRole.name
}


####################################################
