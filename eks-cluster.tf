resource "aws_eks_cluster" "this_aws_eks_cluster" {
  name     = "${var.cluster_name}-${var.env}"
  role_arn = aws_iam_role.this_eks_role.arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids              = var.pub_subnet_ids # public subnets
    endpoint_private_access = false
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
  }

  kubernetes_network_config {
    service_ipv4_cidr = "172.20.0.0/16"
  }

  #Enable EKS control plane logging
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  depends_on = [aws_iam_role_policy_attachment.this_eks-AmazonEKSClusterPolicy, aws_iam_role_policy_attachment.this_eks-AmazonEKSVPCResourceController]


}
