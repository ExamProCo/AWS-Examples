## Install Rails

```sh
gem install rails
```

## Generate a new app

```sh
rails new shogun --skip-git --skip-activerecord --api
```

https://guides.rubyonrails.org/command_line.html#rails-new

# Start App

```sh
cd shogun
bundle exec rails s
```

# Test Endpoint

```sh
curl -X POST  localhost:3000/mariko
```

# Start in production

```sh
bundle exec puma -e production -C config/puma.rb
```

# Create Bucket for Rails Artifact

```sh
aws s3 mb s3://cw-agent-app-325252


# Install These
```sh
sudo yum update -y
sudo yum install -y gcc libyaml-devel ruby-devel libxml2 libxml2-devel libxslt libxslt-devel patch redhat-rpm-config sqlite -y
gem install bundler
gem install rails
aws s3 cp s3://cw-agent-app-325252/app.zip app.zip
unzip app.zip
bundle config set --local path 'vendor/bundle'
bundle install
```

sudo chown ec2-user:ec2-user -R /usr/share/ruby3.2-gems
sudo chown ec2-user:ec2-user -R /usr/share/ruby3.2-rubygems
sudo chown ec2-user:ec2-user -R /usr/lib64/gems/ruby3.2
