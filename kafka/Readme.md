# Kafka Code Examples

https://docs.aws.amazon.com/msk/latest/developerguide/serverless-getting-started.html

```sh
./kafka-topics.sh \
--bootstrap-server $BS \
 --command-config client.properties \
 --create \
--topic my-topic \
--partitions 1
```

```sh
./kafka-console-producer.sh \
--broker-list $BS \
--producer.config client.properties \
--topic my-topic
```


```sh
./kafka-console-consumer.sh \
--bootstrap-server $BS \
--consumer.config client.properties \
--topic my-topic \
 --from-beginning
```

# ------ Failed stuff down below!
# ------
# Download Kafka Client

https://kafka.apache.org/downloads 

```sh
curl https://downloads.apache.org/kafka/3.7.0/kafka_2.13-3.7.0.tgz -o /tmp/kafka.tgz
```

```sh
tar -xvzf /tmp/kafka.tgz
```

Copy this jar into the libs directory of the Kafka Client
```sh
wget https://github.com/aws/aws-msk-iam-auth/releases/download/v2.1.0/aws-msk-iam-auth-2.1.0-all.jar
```

Create client.properties file in the root of the kafka client folder

```sh
security.protocol=SASL_SSL
sasl.mechanism=AWS_MSK_IAM
sasl.jaas.config=software.amazon.msk.auth.iam.IAMLoginModule required;
sasl.client.callback.handler.class=software.amazon.msk.auth.iam.IAMClientCallbackHandler
```

# Allow Public Access for Cluster [Failed]

```sh
aws kafka describe-cluster-v2 \
--cluster-arn "arn:aws:kafka:ca-central-1:982383527471:cluster/MyMSK/173c748b-50b1-4435-b6ab-82eaf8f402b3-s2" \
--query ClusterInfo.CurrentVersion \
--output text
```

```sh
aws kafka update-connectivity \
--current-version "K2EUQ1WTGCTBG2" \
--cluster-arn "arn:aws:kafka:ca-central-1:982383527471:cluster/MyMSK/173c748b-50b1-4435-b6ab-82eaf8f402b3-s2" \
--connectivity-info '{ 
  "PublicAccess": {
    "Type": "SERVICE_PROVIDED_EIPS"
}}'
```

# Create Topic

```sh
./bin/kafka-topics.sh --create \
--bootstrap-server boot-2ixo7kxl.c2.kafka-serverless.ca-central-1.amazonaws.com:9098  \
--command-config client.properties \
 --replication-factor 1 \
 --partitions 1 \
 --topic my-topic
```

./bin/kafka-topics.sh --create \
--bootstrap-server boot-2ixo7kxl.c2.kafka-serverless.ca-central-1.amazonaws.com:9098 \
--command-config client.properties \
--replication-factor 1 \
--partitions 1 \
--topic my-topic


## Setting up Karafka [Failed]

```sh
bundle init
bundle add karafka --version ">= 2.4.0"
bundle exec karafka install
bundle exec karafka server
```