
## Mongo Shell Ubuntu (Jammy)

Get version of ubuntu

https://www.mongodb.com/docs/mongodb-shell/install/
https://www.mongodb.com/docs/mongodb-shell/run-commands/

```sh
lsb_release -a
openssl --version
```

```sh
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
wget -qO- https://www.mongodb.org/static/pgp/server-7.0.asc | sudo tee /etc/apt/trusted.gpg.d/server-7.0.asc
sudo apt-get update
sudo apt-get install -y mongodb-mongosh-shared-openssl3
mongosh --version
```

```sh
mongosh mongodb://docadmin:password@mydocumentdb-982383527471.us-east-1.docdb-elastic.amazonaws.com:27017?retryWrites=false -tls
```