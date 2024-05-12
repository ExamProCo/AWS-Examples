
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

## Install EB CLI

> EB at the the time of this video only works in 3.11 and not 3.12 so we had to install python 3.11 and create a virtualenv

```sh
brew install python@3.11
```

```sh
pip install virtualenv
virtualenv -p python3.11 ~/myenv
source ~/myenv/bin/activate
python --version
pip install awsebcli --upgrade
```

## Manual Install if you don't have to do the virtual enviroment (optional)
```sh
git clone https://github.com/aws/aws-elastic-beanstalk-cli-setup.git
python ./aws-elastic-beanstalk-cli-setup/scripts/ebcli_installer.py
echo 'export PATH="/home/gitpod/.ebcli-virtual-env/executables:$PATH"' >> ~/.bash_profile && source ~/.bash_profile
```

## Initialize EB

```
eb init
```


## Set Codesource

```sh
eb codesource
```

## Zip Directory

```sh
zip -r app.zip app
```

# Unzip Directory

```sh
 unzip app.zip 
```

## Make Config Var for Eb Extensions

mkdir .ebextensions
touch .ebextensions/001_envar.config

## Create IAM Profile


```sh
aws iam create-instance-profile --instance-profile-name StudySyncInstanceProfile
aws iam add-role-to-instance-profile \
    --role-name AWSElasticBeanstalkWebTierRole  \
    --instance-profile-name StudySyncInstanceProfile
```

## Importing into RDS


psql mydatabase < sql/schema.sql -h rds-basic-rdsinstance-uzdzjcuz1opq.cv1x0r3utzcm.ca-central-1.rds.amazonaws.com -U postgres 
psql mydatabase < sql/seed.sql -h rds-basic-rdsinstance-uzdzjcuz1opq.cv1x0r3utzcm.ca-central-1.rds.amazonaws.com -U postgres 