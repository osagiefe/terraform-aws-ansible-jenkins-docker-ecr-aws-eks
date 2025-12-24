# Basic files needed: 
backend.tf, .gitignore, vpc.tf, main.tf, security-group.tf, provider.tf, userdata.sh
# Check terraform version
terraform -version
==========================================
# Terraform Commands

==========================================
# To initialize terraform
terraform init
# To format terraform
terraform fmt
# Validate terraform
terraform validate
# To see what terraform is about to build
terraform plan
# To apply interractive approval of resource provising
terraform apply
# To auto approve resource provising without 
terraform apply --auto-approve
# To destroy infractructure in AWS
terraform destroy --auto-approve