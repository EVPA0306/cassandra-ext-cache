FROM cassandra:latest
COPY build/libs/cassandra-cache-all.jar /etc/cassandra/triggers/trigger-cache.jar
CMD ["cassandra", "-f"]