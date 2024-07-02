output "vpcid" {
  value = aws_vpc.demo-vpc.id
  description = "this output return vpc id"
}
output "vpc_sub_privar_list"{
    value = [aws_subnet.private-subnet-1.id]
}
output "public_subnet_1" {
  value = aws_subnet.public-subnet-1.id
  
}