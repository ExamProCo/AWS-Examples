## KPL

Generate a new java project.
This will create a new directory call kpl-example with a bare bones java project.

```sh
mvn archetype:generate \
-DgroupId=co.exampro \
-DartifactId=kpl-example \
-DarchetypeArtifactId=maven-archetype-quickstart \
-DarchetypeVersion=1.4 \
-DinteractiveMode=false
```

In the pom.xml we will add into the project tag profiles tag
and change our build directory for the outputed binary.

You will have to change the directory based on your developer enviroment.
In our configuration we are using Gitpod so we are leveraging an env var.
You could hardcode this value to go where you need it to go.

```xml
<profiles>
  <profile>
      <id>dev</id>
      <build>
          <directory>${env.THEIA_WORKSPACE_ROOT}/kinesis/datastreams/kpl-example/output</directory>
      </build>
  </profile>
</profiles>
```

We need to add the KPL to our pom.xml depenednecies

https://central.sonatype.com/artifact/com.amazonaws/amazon-kinesis-producer

```xml
<dependency>
    <groupId>com.amazonaws</groupId>
    <artifactId>amazon-kinesis-producer</artifactId>
    <version>0.15.9</version>
</dependency>
```

To package the dependencies will need to use Maven Shade Plugin
- provides the capability to package the artifact in an uber-jar, including its dependencies and to shade

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-shade-plugin</artifactId>
    <version>3.2.2</version>
    <configuration>
        <transformers>
            <transformer
                implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
                <mainClass>co.exampro.App</mainClass>
            </transformer>
        </transformers>
        <shadedArtifactAttached>true</shadedArtifactAttached>
        <shadedArtifactId>application</shadedArtifactId>
    </configuration>
    <executions>
        <execution>
            <phase>package</phase>
            <goals>
                <goal>shade</goal>
            </goals>
        </execution>
    </executions>
</plugin>
```

Build your binary

```sh
mvn clean package shade:shade -Pdev
```

Run your binary

cd $THEIA_WORKSPACE_ROOT/output
java -jar application-1.0-SNAPSHOT-shaded.jar

# Set your env vars

export DATA_STREAM_NAME="datastream-MyStream-mVSDDqynVfJj"
export DATA_STREAM_PARTITION_KEY="456"
export DATA_STREAM_SHARD="shardId-000000000000"

# Test your Datastream using the AWS CLI

Write data
```sh
echo 'Send reinforcements' | base64
aws kinesis put-record --stream-name $DATA_STREAM_NAME --partition-key $DATA_STREAM_PARTITION_KEY --data U2VuZCByZWluZm9yY2VtZW50cwo=
```

Get data

```sh
export SHARD_ITERATOR=$(aws kinesis get-shard-iterator --shard-id $DATA_STREAM_SHARD --shard-iterator-type TRIM_HORIZON --stream-name $DATA_STREAM_NAME --query 'ShardIterator')
aws kinesis get-records --shard-iterator $SHARD_ITERATOR
```