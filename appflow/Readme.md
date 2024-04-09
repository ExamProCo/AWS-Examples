## Upload File

```sh
aws s3 mb s3://appflow-example-13631 --region us-east-1
aws s3 cp babylon5_ships.csv s3://appflow-example-13631/data-babylon5_ships.csv
```

## Install PSQL

Install PSQL Client
```sh
sudo apt-get install -y postgresql-client 
```

Connect to DB

```sh
psql postgresql://postgres:password@my-database.ck6c4llggxsy.us-east-1.rds.amazonaws.com:5432
```


```sh
\c mydatabase
```
```sql
CREATE TABLE babylon5_ships (
    id SERIAL PRIMARY KEY,
    ship_name VARCHAR(255),
    affiliation VARCHAR(255),
    type VARCHAR(100),
    introduced VARCHAR(50),
    length_m VARCHAR(50),
    max_speed VARCHAR(50),
    crew VARCHAR(50)
);
```