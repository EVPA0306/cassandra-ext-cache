package org.apache.cassandra.triggers.log;

public class LogCell {

    private String name;
    private String value;

    public LogCell withName(String name) {
        this.name = name;
        return this;
    }

    public LogCell withValue(String value) {
        this.value = value;
        return this;
    }

    public String getName() {
        return name;
    }

    public String getValue() {
        return value;
    }
}
