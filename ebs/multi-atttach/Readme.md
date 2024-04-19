https://docs.aws.amazon.com/ebs/latest/userguide/ebs-volumes-multi.html


# Commands we used

## Format and Mount EC2 1

```sh
sudo mkfs -t xfs /dev/sdh
sudo mkdir /newvolume
sudo mount /dev/sdh /newvolume
cd /newvolume
touch hello.txt
```

## Just Mount EC2 2

```sh
sudo mkdir /newvolume
sudo mount /dev/sdh /newvolume
```