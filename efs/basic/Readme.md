
## Setting UP

```sh
sudo yum install -y amazon-efs-utils
sudo mkdir /mnt/efs
```

## Mounting

```sh
sudo mount -t efs -o tls fs-0bf948f125e97f2d2:/ /mnt/efs
```