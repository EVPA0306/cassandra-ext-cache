package org.apache.cassandra.triggers;

import org.apache.http.HttpHost;
import org.elasticsearch.action.admin.indices.create.CreateIndexRequest;
import org.elasticsearch.action.admin.indices.create.CreateIndexResponse;
import org.elasticsearch.action.admin.indices.delete.DeleteIndexRequest;
import org.elasticsearch.action.admin.indices.delete.DeleteIndexResponse;
import org.elasticsearch.action.index.IndexResponse;
import org.elasticsearch.client.Client;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.TransportAddress;
import org.elasticsearch.common.xcontent.XContentBuilder;
import org.elasticsearch.common.xcontent.XContentType;
import org.elasticsearch.node.Node;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;

import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import static org.elasticsearch.common.xcontent.XContentFactory.jsonBuilder;

public class ElasticSearchTest {

    public RestHighLevelClient client;

    //@BeforeClass
    //public static void setUp() {
    //    client = initializeClient("localhost","9300");
    //}

    @Test
    public void createClientTest() {
        client = initializeClient("localhost","9300");
        Assert.assertNotNull(client);
    }

    @Test
    public void testJSON() throws IOException, ParseException {

        JSONParser parser = new JSONParser();
        InputStream inputStream = SendMessageTrigger.class.getClassLoader()
                .getResourceAsStream("cass.json");
        Object obj = parser.parse(new InputStreamReader(inputStream));
        JSONObject jsonObject = (JSONObject) obj;
        System.out.println(jsonObject);
    }

    @Test
    public void deleteIndexTest() throws IOException {

        client = initializeClient("localhost","9200");
        DeleteIndexRequest request = new DeleteIndexRequest("twitter");
        DeleteIndexResponse deleteIndexResponse = client.indices().delete(request);
    }

    @Test
    public void createIndexTest() throws IOException, ParseException {

        client = initializeClient("localhost","9200");
        JSONParser parser = new JSONParser();

        InputStream inputStream = SendMessageTrigger.class.getClassLoader()
                .getResourceAsStream("cass.json");
        Object obj = parser.parse(new InputStreamReader(inputStream));

        JSONObject jsonObject = (JSONObject) obj;
        //System.out.println(jsonObject.toJSONString());

        CreateIndexRequest request = new CreateIndexRequest("twitter");

        /*request.settings(Settings.builder()
                .put("index.number_of_shards", 3)
                .put("index.number_of_replicas", 2)
        );*/

        Map<String, Object> json = new HashMap<String, Object>();
        json.put("user","kimchy");
        json.put("postDate",new Date());
        json.put("message","trying out Elasticsearch");

        request.mapping("tweet", json, XContentType.JSON);

        CreateIndexResponse createIndexResponse = client.indices().create(request);

        //if (localClient != null)
        //    localClient.close();
    }

    private RestHighLevelClient initializeClient(String host, String port) {

        RestHighLevelClient client = new RestHighLevelClient(
                RestClient.builder(
                        new HttpHost(host, Integer.valueOf(port), "http")));
        return client;
    }
}
