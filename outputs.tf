output "cluster_id" {
  value = aws_eks_cluster.this_aws_eks_cluster.id
}

output "cluster_arn" {
  value = aws_eks_cluster.this_aws_eks_cluster.arn
}

output "cluster_certificate_authority_data" {
  value = aws_eks_cluster.this_aws_eks_cluster.certificate_authority[0].data
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this_aws_eks_cluster.endpoint
}

output "cluster_version" {
  value = aws_eks_cluster.this_aws_eks_cluster.version
}

output "cluster_iam_role_name" {
  value = aws_eks_cluster.this_aws_eks_cluster.name
}

output "cluster_iam_role_arn" {
  value = aws_eks_cluster.this_aws_eks_cluster.arn
}


output "cluster_oidc_issuer_url" {
  value = aws_eks_cluster.this_aws_eks_cluster.identity[0].oidc[0].issuer
}


output "cluster_primary_security_group_id" {
  value = aws_eks_cluster.this_aws_eks_cluster.vpc_config[0].cluster_security_group_id
}


# EKS node groups
output "node_group_public_id" {
  value = aws_eks_node_group.this_aws_eks_node_group_pub.id
}


output "node_group_public_arn" {
  value = aws_eks_node_group.this_aws_eks_node_group_pub.arn
}

output "node_group_public_status" {
  value = aws_eks_node_group.this_aws_eks_node_group_pub.status
}

output "node_group_public_version" {
  value = aws_eks_node_group.this_aws_eks_node_group_pub.version
}

output "node_group_public_release_version" {
  value = aws_eks_node_group.this_aws_eks_node_group_pub.release_version
}

# Private


output "node_group_private_id" {
  value = aws_eks_node_group.this_aws_eks_node_group_pri.id
}


output "node_group_private_arn" {
  value = aws_eks_node_group.this_aws_eks_node_group_pri.arn
}

output "node_group_private_status" {
  value = aws_eks_node_group.this_aws_eks_node_group_pri.status
}

output "node_group_private_version" {
  value = aws_eks_node_group.this_aws_eks_node_group_pri.version
}

output "node_group_private_release_version" {
  value = aws_eks_node_group.this_aws_eks_node_group_pri.release_version
}


#OIDC

output "aws_iam_openid_connect_provider_arn" {
  value = aws_iam_openid_connect_provider.this_oidc_provider.arn
}

output "aws_iam_oidc_connect_provider_extract_from_arn" {
  value = local.aws_iam_oidc_connect_provider_extract_from_arn
}






