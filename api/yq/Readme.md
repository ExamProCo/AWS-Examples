brew install yq

aws ec2 describe-vpcs | yq . -pjson -oy
aws ec2 describe-vpcs | yq ".Vpcs[].CidrBlock" -pjson -oy
