## Install docker container and show us the version

 docker run --rm -it amazon/aws-cli --version

 ## Attempt to list our s3 buckets

 docker run --rm -it amazon/aws-cli s3 ls

 ## Connect with credentials

 docker run --rm -it \
-v  ~/.aws:/root/.aws \
public.ecr.aws/aws-cli/aws-cli \
s3 ls