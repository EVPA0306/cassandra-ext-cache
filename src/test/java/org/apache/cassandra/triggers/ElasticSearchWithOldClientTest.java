package org.apache.cassandra.triggers;

import org.apache.http.HttpHost;
import org.elasticsearch.action.index.IndexResponse;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.TransportAddress;
import org.elasticsearch.common.xcontent.XContentType;
import org.elasticsearch.transport.client.PreBuiltTransportClient;
import org.junit.Assert;
import org.junit.Test;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class ElasticSearchWithOldClientTest {

    @Test
    public void createClientTest() {
        TransportClient client = initializeClient("localhost","9300");
        Assert.assertNotNull(client);
    }

    @Test
    public void createIndexWithMapTest() {

        TransportClient client = initializeClient("localhost", "9300");

        Map<String, Object> json = new HashMap<String, Object>();

        json.put("user","kimchy");
        json.put("postDate",new Date());
        json.put("message","trying out Elasticsearch");

        IndexResponse response = client.prepareIndex("twitter", "tweet")
                .setSource(json, XContentType.JSON)
                .get();
    }

    private TransportClient initializeClient(String host, String port) {
        TransportClient client = null;
        try {
            client = new PreBuiltTransportClient(Settings.EMPTY)
                    .addTransportAddress(new TransportAddress(InetAddress.getByName(host),Integer.valueOf(port)));
        } catch (UnknownHostException e) {
            throw new RuntimeException(e);
        }
        return client;
    }
}
