
# Install MySQL and PSQL Client

```sh
sudo apt-get install -y postgresql-client 
sudo apt-get install -y mysql-client 
```

## Assemble PSQL Connection String

postgresql://postgres:password@<hostname>:3306/mydatabase

## Assemble MySQL Connection String

mysql://admin:password@<hostname>:5432/mydatabase


mysql -u admin -ppassword -h database-2.ck6c4llggxsy.us-east-1.rds.amazonaws.com -P 5432 database
psql postgresql://postgres:password@rds-dms-postgres-rdsinstance-ghj0ttbqkmaf.cv1x0r3utzcm.ca-central-1.rds.amazonaws.com:3306/mydatabase



