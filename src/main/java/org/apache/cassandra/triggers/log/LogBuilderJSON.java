package org.apache.cassandra.triggers.log;

import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

public class LogBuilderJSON implements LogBuilder {

    private static final Logger LOGGER = LoggerFactory.getLogger(LogBuilderJSON.class);

    @Override
    public LogEntry build() {
        return new LogEntry();
    }

    @Override
    public String convert(LogEntry logEntry) {
        return convert(logEntry,false);
    }

    @Override
    public String convert(LogEntry logEntry, boolean pretty) {
        String logToJson = "{}";
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            if (pretty) {
                logToJson = objectMapper.writerWithDefaultPrettyPrinter().writeValueAsString(logEntry);
            } else {
                logToJson = objectMapper.writeValueAsString(logEntry);
            }
        } catch (IOException e) {
            LOGGER.error(e.getMessage());
        }
        return logToJson;
    }
}
