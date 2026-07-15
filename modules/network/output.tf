output "vpc_id" { value = aws_vpc.this.id }
output "eks_subnet_ids" { value = aws_subnet.eks[*].id }
