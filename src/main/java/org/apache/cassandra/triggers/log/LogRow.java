package org.apache.cassandra.triggers.log;

import java.util.List;

public class LogRow {
    private List<LogCell> cells;

    public LogRow withCells(List<LogCell> cells) {
        this.cells = cells;
        return this;
    }

    public List<LogCell> getCells() {
        return cells;
    }
}
