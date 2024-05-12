
### Install Deps

```sh
npm install
```

### Start Server


```sh
DATABASE_URL="postgresql://postgres:password@localhost:5432/study-sync" PORT=4567 npm start
```

# Run Postgres Server

```sh
docker compose up
```

## Install Postgres Client

```
sudo apt install postgres
```

## Create initial database

```sh
createdb study-sync -h localhost -U postgres
```

## Connect to Postgres Client

sh```
psql postgresql://postgres:password@localhost:5432/study-sync
```

https://github.com/omenking/aws-bootcamp-cruddur-2023/blob/main/journal/week04.md

## Create a postgres table

## Create Schema

psql study-sync < sql/schema.sql -h localhost -U postgres

## Import Data

psql study-sync < sql/seed.sql -h localhost -U postgres

## Verify Data

sh```
psql postgresql://postgres:password@localhost:5432/study-sync
```

```sql
SELECT * FROM questions;
```
