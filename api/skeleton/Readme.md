## Generate our skeleton for EC2

--image-id ami-079db87dc4c10ac91 \
--instance-type t2.micro \
--region us-east-1 \

aws ec2 run-instances --generate-cli-skeleton > skeleton.json

## Convert Json to YAML

yq -oy -p=json skeleton.json > skeleton.yaml 

## Load Yaml input file

aws ec2 run-instances  --cli-input-yaml file://skeleton.yaml --region us-east-1