#!/bin/bash

echo "I: Initializing keyspace.."
./stress -D nodes --consistency-level=ONE --threads=10 --replication-factor=1 --column-size=32  --num-keys=500
echo "I: Updating Replica Strategy for keyspace to NetworkTopologyStrategy.."
/opt/cassandra/bin/cassandra-cli -h `head -n1 nodes.1`  --file schema.txt

exit 0
