######## CNI ###############################

data "aws_eks_addon_version" "add_on_vpc_cni_version_default" {
  addon_name         = "vpc-cni"
  kubernetes_version = aws_eks_cluster.this_aws_eks_cluster.version
}


resource "aws_eks_addon" "vpc-cni" {
  # depends_on                  = [aws_eks_cluster.this_aws_eks_cluster]
  addon_name                  = "vpc-cni"
  cluster_name                = aws_eks_cluster.this_aws_eks_cluster.name
  addon_version               = data.aws_eks_addon_version.add_on_vpc_cni_version_default.version
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
  service_account_role_arn    = aws_iam_role.this_AmazonEKSVPCCNIRole.arn
}


output "vpccni-arn" {
  value = aws_eks_addon.vpc-cni.arn
}

output "vpccni-id" {
  value = aws_eks_addon.vpc-cni.id
}

output "vpccni-current-version" {
  value = data.aws_eks_addon_version.add_on_vpc_cni_version_default.version
}

###################################################
#### COREDNS ######################
data "aws_eks_addon_version" "coredns_addon_version" {
  addon_name         = "coredns"
  kubernetes_version = aws_eks_cluster.this_aws_eks_cluster.version
}


resource "aws_eks_addon" "coredns" {
  addon_name                  = "coredns"
  cluster_name                = aws_eks_cluster.this_aws_eks_cluster.name
  addon_version               = data.aws_eks_addon_version.coredns_addon_version.version
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
}

output "coredns-current-version" {
  value = data.aws_eks_addon_version.coredns_addon_version.version
}

###########################################

##### KUBE_PROXY ###########################

data "aws_eks_addon_version" "kube-proxy-addon-version" {
  addon_name         = "kube-proxy"
  kubernetes_version = aws_eks_cluster.this_aws_eks_cluster.version
}

resource "aws_eks_addon" "kube-proxy" {
  addon_name                  = "kube-proxy"
  addon_version               = data.aws_eks_addon_version.kube-proxy-addon-version.version
  cluster_name                = aws_eks_cluster.this_aws_eks_cluster.name
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
}

output "kube-proxy-current-version" {
  value = data.aws_eks_addon_version.kube-proxy-addon-version.version
}

########################################

### AWS EBS-CSI Driver ###################

data "aws_eks_addon_version" "addon_aws-ebs-csi-driver_version" {
  addon_name         = "aws-ebs-csi-driver"
  kubernetes_version = aws_eks_cluster.this_aws_eks_cluster.version
}


resource "aws_eks_addon" "aws-ebs-csi-driver" {
  addon_name                  = "aws-ebs-csi-driver"
  cluster_name                = aws_eks_cluster.this_aws_eks_cluster.name
  addon_version               = data.aws_eks_addon_version.addon_aws-ebs-csi-driver_version.version
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
  service_account_role_arn    = aws_iam_role.this_AmazonEKS_EBS_CSI_DriverRole.arn
}


output "aws-ebs-csi-driver-current-version" {
  value = data.aws_eks_addon_version.addon_aws-ebs-csi-driver_version.version
}

#######################################################################
