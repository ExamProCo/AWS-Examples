# Start Postgres

```sh
docker compose up
```

# Create our rails projects

```sh
 rails new example -A -J -T -d postgresql
 cd example
```

> Update db/database.yml to have our username and password based on our local psql databases

## Install packages

```sh
bundle install
```

# Start our rails project

```sh
bundle exec rails s -b 0.0.0.0
```

# Create Database

```sh
bundle exec rails db:create
```

# Migrate Databse

```sh
bundle exec rails db:migrate
```

## Install EB CLI

https://github.com/aws/aws-elastic-beanstalk-cli-setup


git clone https://github.com/aws/aws-elastic-beanstalk-cli-setup.git
python ./aws-elastic-beanstalk-cli-setup/scripts/ebcli_installer.py

## Package or EB

zip -r package.zip .