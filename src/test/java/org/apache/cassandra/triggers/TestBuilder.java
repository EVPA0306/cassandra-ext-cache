package org.apache.cassandra.triggers;

import org.apache.cassandra.triggers.log.*;
import org.junit.Test;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class TestBuilder {

    @Test
    public void mainTest()  {

        LogBuilder logBuilder = new LogBuilderJSON();
        LogEntry logEntry = logBuilder.build();
        logEntry.withPrimaryKey("1106");
        logEntry.withClusterKey("3, 2018-04-11 17:58Z");

        List<LogCell> logCells = new ArrayList<>();
        logCells.add(new LogCell().withName("endtime").withValue("2018-04-12 17:58Z"));
        logCells.add(new LogCell().withName("metadata").withValue("{\"episodeTitle\":\"Breaking Bad\"}"));
        logCells.add(new LogCell().withName("seriesid").withValue("SH00380341001"));
        logCells.add(new LogCell().withName("tmsprgid").withValue("SH015547980001"));
        LogRow logRow = new LogRow().withCells(logCells);
        logEntry.withRow(logRow);

        System.out.println(logBuilder.convert(logEntry,true));
    }
}
