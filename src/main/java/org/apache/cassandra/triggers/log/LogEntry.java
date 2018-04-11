package org.apache.cassandra.triggers.log;

import java.util.List;

public class LogEntry {

    private String primaryKey;
    private String clusterKey;
    private LogRow row;

    LogEntry() {}

    public LogEntry withPrimaryKey(String primaryKey) {
        this.primaryKey = primaryKey;
        return this;
    }

    public LogEntry withClusterKey(String clusterKey) {
        this.clusterKey = clusterKey;
        return this;
    }

    public LogEntry withRow(LogRow row) {
        this.row = row;
        return this;
    }

    public String getPrimaryKey() {
        return primaryKey;
    }

    public String getClusterKey() {
        return clusterKey;
    }

    public LogRow getRow() {
        return row;
    }
}
