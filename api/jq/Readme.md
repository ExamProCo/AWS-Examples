aws ec2 describe-vpcs | jq .
aws ec2 describe-vpcs | jq .Vpcs # select Vpcs key from the root of the json object
aws ec2 describe-vpcs | jq Vpcs # this will return an error because we are not selecting from the root of the json
aws ec2 describe-vpcs | jq .Vpcs[] # select the array of VPCs returning back jsons objects
aws ec2 describe-vpcs | jq .Vpcs.CidrBlock # this will error out because we are attempt to select an attribute on array and not the array objects
aws ec2 describe-vpcs | jq .Vpcs?.CidrBlock? # if encountering an error just ignore it
aws ec2 describe-vpcs | jq .Vpcs[].CidrBlock # get back all attribute CidrBlocks from the array of objects
aws ec2 describe-vpcs | jq .Vpcs[1].CidrBlock # get back attribute CidrBlock from second VPC
aws ec2 describe-vpcs | jq .Vpcs[1:2].CidrBlock # this will return an error because the range will return and array
aws ec2 describe-vpcs | jq .Vpcs[1:1] # this will return nothing because its an index that is equal to 0
aws ec2 describe-vpcs | jq .Vpcs[1:2][].CidrBlock # # get back the vpc within the range of 1 and 2 and return the CidrBlock
aws ec2 describe-vpcs | jq .Vpcs[1,2] # get the second and third VPC
aws ec2 describe-vpcs | jq .Vpcs[1,2].CidrBlock
aws ec2 describe-vpcs | jq .Vpcs[1].CidrBlock,.Vpcs[1].VpcId
aws ec2 describe-vpcs | jq .Vpcs[1,2].CidrBlock,.Vpcs[1,2].VpcId
aws ec2 describe-vpcs | jq ".Vpcs[] | .CidrBlock"
aws ec2 describe-vpcs | jq '.Vpcs[] | .CidrBlock,.VpcId'
aws ec2 describe-vpcs | jq '{cidr: Vpcs[].CidrBlock, id: Vpcs[].CidrBlock }' # this will result in an error
aws ec2 describe-vpcs | jq '{cidr: .Vpcs[0].CidrBlock, id: .Vpcs[0].VpcId }' format the first VPC in this format.
aws ec2 describe-vpcs | jq '{cidr: .Vpcs[0,1].CidrBlock, id: .Vpcs[0,1].VpcId }'

aws ec2 describe-vpcs | jq '.Vpcs[0,1] | {CidrBlock,VpcId}'
aws ec2 describe-vpcs | jq '.Vpcs[0,1] | {cidr: CidrBlock, id: VpcId}' # no root being selected
aws ec2 describe-vpcs | jq '.Vpcs[0,1] | {cidr: .CidrBlock, id: .VpcId}'

export USERNAME='andrewbrown'
export PASSWORD='testing123'
jq --null-input \
  --arg user "$USERNAME" \
  --arg password "$PASSWORD" \
  '{"user": $user, "password": $password}'
jq --null-input \
  --arg user "$USERNAME" \
  --arg password "$PASSWORD" \
  '{"user": $user, "password": $password}' > creds.json
cat creds.json