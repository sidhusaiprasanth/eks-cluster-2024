resource "aws_iam_role" "this_eks_node_group_role" {
  name = "${var.cluster_name}-${var.env}-eks-node-group-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "this_AmazonEKSWorkerNodePolicy" {
  role       = aws_iam_role.this_eks_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}


resource "aws_iam_role_policy_attachment" "this_AmazonEC2ContainerRegistryReadOnly" {
  role       = aws_iam_role.this_eks_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}


resource "aws_iam_role_policy_attachment" "this_AmazonEKS_CNI_Policy" {
  role       = aws_iam_role.this_eks_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}





