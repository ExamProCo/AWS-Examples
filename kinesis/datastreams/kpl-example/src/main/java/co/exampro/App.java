package co.exampro;
import com.amazonaws.services.kinesis.producer.KinesisProducer;
import java.nio.ByteBuffer;

import com.amazonaws.services.kinesis.producer.UserRecordResult;
import com.amazonaws.services.kinesis.producer.Attempt;
import java.nio.ByteBuffer;
import java.util.List;
import java.util.LinkedList;
import java.util.concurrent.Future;
import java.util.concurrent.ExecutionException; // For handling the exceptions from Future.get()
import java.nio.charset.StandardCharsets; // For using StandardCharsets.UTF_8


public class App 
{
    public static void main( String[] args )
    {
        // Need to update these!
        String streamName = System.getenv("DATA_STREAM_NAME");
        String partitionKey = System.getenv("DATA_STREAM_PARTITION_KEY");

        System.out.println("Hello World!");

        System.out.println("DATA_STREAM_NAME: " + streamName);
        System.out.println("DATA_PARTITION_KEY: " + partitionKey);

        KinesisProducer kinesis = new KinesisProducer(); 
        List<Future<UserRecordResult>> putFutures = new LinkedList<Future<UserRecordResult>>(); 

        for (int i = 0; i < 5; ++i) {
           ByteBuffer data = null;
            System.out.println("LOOP");
           try {
                data = ByteBuffer.wrap("myData".getBytes("UTF-8"));
            } catch (java.io.UnsupportedEncodingException e) {
                 e.printStackTrace(); // handle the exception here
            }
            // doesn't block       

            putFutures.add(
                kinesis.addUserRecord(streamName, partitionKey, data)
            );
        }          


        for (Future<UserRecordResult> f : putFutures) {
            try {
                UserRecordResult result = f.get(); // This does block
                if (result.isSuccessful()) {
                    System.out.println("Put record into shard " + result.getShardId());
                } else {
                    for (Attempt attempt : result.getAttempts()) {
                        // Analyze and respond to the failure
                        System.out.println("Record Put Failed");
                    }
                }
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt(); // handle the InterruptedException
                System.out.println("Interrupted Exception");
            } catch (ExecutionException e) {
                System.out.println("Execution Exception");
                e.printStackTrace(); // handle the ExecutionException
            }
        }
        System.out.println( "Goodbye World!" );
    }
}
