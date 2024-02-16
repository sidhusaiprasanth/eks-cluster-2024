data "aws_partition" "current" {}

resource "aws_iam_openid_connect_provider" "this_oidc_provider" {
  client_id_list  = ["sts.${data.aws_partition.current.dns_suffix}"]
  thumbprint_list = [var.eks_oidc_root_ca_thumbprint]
  url             = aws_eks_cluster.this_aws_eks_cluster.identity[0].oidc[0].issuer
  tags = {
    "Name" = "${var.cluster_name}-eks-irsa"
  }
}

locals {
  aws_iam_oidc_connect_provider_extract_from_arn = element(split("oidc-provider/", "${aws_iam_openid_connect_provider.this_oidc_provider.arn}"), 1)
}
