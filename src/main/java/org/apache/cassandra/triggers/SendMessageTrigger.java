package org.apache.cassandra.triggers;

import org.apache.cassandra.config.ColumnDefinition;
import org.apache.cassandra.db.Clustering;
import org.apache.cassandra.db.Mutation;
import org.apache.cassandra.db.partitions.Partition;
import org.apache.cassandra.db.rows.Cell;
import org.apache.cassandra.db.rows.Row;
import org.apache.cassandra.db.rows.Unfiltered;
import org.apache.cassandra.db.rows.UnfilteredRowIterator;
import org.apache.cassandra.io.util.FileUtils;
import org.apache.cassandra.triggers.log.*;
import org.apache.http.HttpHost;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestHighLevelClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.InputStream;
import java.util.*;


public class SendMessageTrigger implements ITrigger {

    private static final Logger LOGGER = LoggerFactory.getLogger(SendMessageTrigger.class);
    private RestHighLevelClient elasticClient;
    private LogEntry logEntry;
    private LogBuilder logBuilder;
    private Properties properties = loadProperties();

    public SendMessageTrigger() {
        logBuilder = new LogBuilderJSON();
        logEntry = logBuilder.build();
    }

    @Override
    public Collection<Mutation> augment(Partition partition) {

        String auditKeyspace = properties.getProperty("keyspace");
        String auditTable = properties.getProperty("table");
        String clusterHost = properties.getProperty("elasticsearch_cluster");
        String clusterPort = properties.getProperty("elasticsearch_port");

        //elasticClient = initializeClient(clusterHost,clusterPort);

        readPartition(partition);

        return Collections.emptyList();
    }

    private RestHighLevelClient initializeClient(String host, String port) {

        RestHighLevelClient client = new RestHighLevelClient(
                RestClient.builder(
                        new HttpHost(host, Integer.valueOf(port), "http")
                        ));
        return client;
    }


    private void readPartition(Partition partition) {

        String primaryKey = getKey(partition);

        logEntry.withPrimaryKey(primaryKey);
        LOGGER.info("PRIMARY KEY:: {}", primaryKey);

        if (partitionIsDeleted(partition)) {
            LOGGER.info("PARTITION DELETED");
        }

        UnfilteredRowIterator unfilteredRowIterator = partition.unfilteredIterator();

        while (unfilteredRowIterator.hasNext()) {
        //an Unfiltered is either a row or a range tombstone marker
            Unfiltered unfiltered = unfilteredRowIterator.next();

                if (unfiltered.isRow()) {

                    Clustering clustering = (Clustering) unfiltered.clustering();
                    String clusteringKey = clustering.toCQLString(partition.metadata());

                    logEntry.withClusterKey(clusteringKey);
                    LOGGER.info("CLUSTERING KEY: {}", clusteringKey);
                    Row row = partition.getRow(clustering);

                    if (!rowIsDeleted(row)) {
                        //
                        Iterator<Cell> cells = row.cells().iterator();
                        Iterator<ColumnDefinition> columns = row.columns().iterator();

                        List<LogCell> cellObjects = new ArrayList<>();
                        while (cells.hasNext() && columns.hasNext()) {

                            LogCell logCell = new LogCell();
                            ColumnDefinition columnDef = columns.next();
                            Cell cell = cells.next();

                            logCell.withName(columnDef.name.toString());

                            if (!cell.isTombstone()) {
                                String data = columnDef.type.getString(cell.value());
                                logCell.withValue(data);
                            } else {
                                logCell.withValue(null);
                            }
                            cellObjects.add(logCell);
                        }
                        logEntry.withRow(new LogRow().withCells(cellObjects));
                    }
                }
            }

        LOGGER.info("FINAL VALUE: {}", logBuilder.convert(logEntry,true));

    }

    private boolean partitionIsDeleted(Partition partition) {
        return partition.partitionLevelDeletion().markedForDeleteAt() > Long.MIN_VALUE;
    }

    private boolean rowIsDeleted(Row row) {
        return row.deletion().time().markedForDeleteAt() > Long.MIN_VALUE;
    }

    private String getKey(Partition partition) {
        return partition.metadata().getKeyValidator().getString(partition.partitionKey().getKey());
    }

    private static Properties loadProperties() {

        Properties properties = new Properties();
        InputStream inputStream = SendMessageTrigger.class.getClassLoader()
                .getResourceAsStream("SendMessageTrigger.properties");
        try {
            properties.load(inputStream);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } finally {
            FileUtils.closeQuietly(inputStream);
        }
        return properties;
    }
}