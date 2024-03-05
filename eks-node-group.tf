data "aws_ssm_parameter" "eks_ami_release_version" {
  name = "/aws/service/eks/optimized-ami/${aws_eks_cluster.this_aws_eks_cluster.version}/amazon-linux-2/recommended/release_version"
}


resource "aws_eks_node_group" "this_aws_eks_node_group_pub" {
  cluster_name    = aws_eks_cluster.this_aws_eks_cluster.name
  node_group_name = "${var.cluster_name}-${var.env}-pub-node-group"
  node_role_arn   = aws_iam_role.this_eks_node_group_role.arn
  subnet_ids      = var.pub_subnet_ids                           # Publicsubnets
  version         = aws_eks_cluster.this_aws_eks_cluster.version // default to eks cluster version

  release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)

  ami_type       = "AL2_x86_64"
  capacity_type  = "ON_DEMAND"
  disk_size      = 20
  instance_types = ["t3.medium"]


  remote_access {
    ec2_ssh_key = "eks-terraform-key"
  }


  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 1

  }

  update_config {
    max_unavailable = 1
    #max_unavailable_percentage = 50 
  }

  depends_on = [aws_iam_role_policy_attachment.this_AmazonEKSWorkerNodePolicy, aws_iam_role_policy_attachment.this_AmazonEKS_CNI_Policy, aws_iam_role_policy_attachment.this_AmazonEC2ContainerRegistryReadOnly]

  tags = merge({
    Name = "Public-Node-Group"
  }, var.default_tags)
}




resource "aws_eks_node_group" "this_aws_eks_node_group_pri" {
  cluster_name    = aws_eks_cluster.this_aws_eks_cluster.name
  node_group_name = "${var.cluster_name}-${var.env}-pri-node-group"
  node_role_arn   = aws_iam_role.this_eks_node_group_role.arn
  subnet_ids      = var.pri_subnet_ids                           # Privatesubnets
  version         = aws_eks_cluster.this_aws_eks_cluster.version // default to eks cluster version

  release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)
  ami_type        = "AL2_x86_64"
  capacity_type   = "ON_DEMAND"
  disk_size       = 20
  instance_types  = ["t3.medium"]

  remote_access {
    ec2_ssh_key = "eks-terraform-key"
  }


  scaling_config {
    desired_size = 0
    min_size     = 1
    max_size     = 1

  }

  update_config {
    max_unavailable = 1
    #max_unavailable_percentage = 50 
  }

  depends_on = [aws_iam_role_policy_attachment.this_AmazonEKSWorkerNodePolicy, aws_iam_role_policy_attachment.this_AmazonEKS_CNI_Policy, aws_iam_role_policy_attachment.this_AmazonEC2ContainerRegistryReadOnly]

  tags = merge({
    Name = "Private-Node-Group"
  }, var.default_tags)
}
