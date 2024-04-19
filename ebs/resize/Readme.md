
# Modify Volume
```sh
aws ec2 modify-volume --size 12 --volume-id vol-098b39dabf29eaa66
```

# Extend Filesystem

```sh
sudo growpart /dev/nvme0n1 1
sudo xfs_growfs -d /
```

> growpart is used to expand the partition to the whole disk. xfs_growfs is used to resize and apply the changes.

https://docs.aws.amazon.com/ebs/latest/userguide/recognize-expanded-volume-linux.html
https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/modify-volume.html#examples