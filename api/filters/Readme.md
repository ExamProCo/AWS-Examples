# Get a bunch of subnets
 
aws ec2 describe-subnets --region us-east-1  --query Subnets[].AvailabilityZone

aws ec2 describe-subnets --region us-east-1  --filter Name=availability-zone,Values=us-east-1b,us-east-1a  --query Subnets[].AvailabilityZone