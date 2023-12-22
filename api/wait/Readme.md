## Create an EC2 instance

INSTANCE_ID=$(aws ec2 run-instances \
--image-id "ami-079db87dc4c10ac91" \
--instance-type t2.micro \
--region us-east-1 \
--query Instances[].InstanceId \
--output text)

## To watch for EC2 instance to be ready

aws ec2 wait instance-status-ok --instance-ids $INSTANCE_ID --region us-east-1