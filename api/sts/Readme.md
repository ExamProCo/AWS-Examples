## Create a user with no permissions

We need to create a new user with no permissions and generate out access keys

```sh
aws iam create-user --user-name sts-machine-user
aws iam create-access-key --user-name sts-machine-user --output table
```

Copy the access key and secret here
```sh
aws configure
```

Then edit credentials file to change away from default profile

```sh
open ~/.aws/credentials 
```

Test who you are:

```sh
aws sts get-caller-identity
aws sts get-caller-identity --profile sts
```

Make sure you don't have access to S3

```sh
aws s3 ls --profile sts
```
> An error occurred (AccessDenied) when calling the ListBuckets operation: Access Denied

## Create a Role

We need to create a role that will access a new resource

```sh
chmod u+x bin/deploy
./bin/deploy
```

## Use new user crednetials and assume role

```sh
aws iam put-user-policy \
--user-name sts-machine-user  \
--policy-name StsAssumePolicy \
--policy-document file://policy.json
```

```sh
aws sts assume-role \
--role-arn arn:aws:iam::982383527471:role/my-sts-fun-stack-StsRole-UBQlCIzagA7n \
--role-session-name s3-sts-fun \
--profile sts
```

```sh
aws sts get-caller-identity --profile assumed
```

```sh
aws s3 ls --profile assumed
```

## Cleanup

tear down your cloudformation stack via the AWS Managemnet Console

```sh
aws iam delete-user-policy --user-name sts-machine-user --policy-name StsAssumePolicy
aws iam delete-access-key --access-key-id AKIA6JOU7AYXR3PVODP3 --user-name sts-machine-user
aws iam delete-user --user-name sts-machine-user
```
