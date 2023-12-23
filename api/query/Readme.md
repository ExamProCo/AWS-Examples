
ec2 describe-vpcs --query Vpcs[].[CidrBlocck,VpcId]

aws ec2 describe-vpcs --query 'Vpcs[].{cidr: CidrBlock, vpcid: VpcId}' --output json