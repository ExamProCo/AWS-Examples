# Create Subnet Group

aws memorydb create-subnet-group \
--subnet-group-name mysubnetgroup \
--description "my subnet group" \
--subnet-ids subnet-0e0fd31733061237d subnet-0c96245f8e4d94ed6 \
--query SubnetGroup.ARN \
--output text

> Dont use the default vpc. create a vpc with subnets

# Create User

aws memorydb create-user \
--user-name andrewbrown \
--access-string "on ~* &* +@all" \
--authentication-mode Passwords="Testing12345678901234567890!",Type=password

# Create ACL

aws memorydb create-acl \
    --acl-name "new-acl-1" \
    --user-names "andrewbrown"

# Create Cluster

```sh
aws memorydb create-cluster \
--cluster-name my-new-cluster \
--node-type db.t4g.small \
--acl-name new-acl-1 \
--subnet-group mysubnetgroup
```