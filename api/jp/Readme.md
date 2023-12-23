aws ec2 describe-vpcs | jp # this will return in an error
aws ec2 describe-vpcs | jp Vpcs # we need to select something
aws ec2 describe-vpcs | jp "Vpcs[?IsDefault == false]"
aws ec2 describe-vpcs | jp "Vpcs[*].CidrBlock

aws ec2 describe-vpcs | jp "Vpcs[*].CidrBlock | {Blocks: join(',',@) } "
aws ec2 describe-vpcs --query "Vpcs[*].CidrBlock | { Blocks: join(',',@) }"