module "aws_key_pair"{
  source = "./modules/aws_key_pair"
}
module "aws_instance" {
  source = "./modules/aws_instances"
  key_pair = module.aws_key_pair.key_pair
  subnet_id = module.vpc.public_subnet_1
  
}



module "vpc" {
  source = "./modules/vpc"

}