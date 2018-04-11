package org.apache.cassandra.triggers.log;

public interface LogBuilder {
    LogEntry build();
    String convert(LogEntry logEntry);
    String convert(LogEntry logEntry, boolean pretty);

}
