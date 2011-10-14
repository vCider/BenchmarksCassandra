#!/bin/bash

# Wait for first batch to get over. Sleep for 10 minutes if the run is in progress. 
while [  `pgrep batch2.sh` ]
do
   echo "I: BATCH 1 IN PROGRESS"
   sleep 600
done
   echo "I: Launching Batch 2..."


#########################

time ./autorun_tests_multidc.sh --consistency-level=LOCAL_QUORUM --threads=1  --replication-strategy=NetworkTopologyStrategy --strategy-properties=us-east:2,us-west:2 --column-size=256 --keep-going --num-keys=10000 -r  > /opt/cassandra/tools/results/112_vcider-0.4.0_MultiDC_EncryptionOFF_T-1_C-LOCAL_QUORUM_R-2_R_2_B-256.log 2>&1
/opt/cassandra/tools/stress/bin/autocommit.sh > /var/log/autocommit.log 2>&1

time ./autorun_tests_multidc.sh --consistency-level=LOCAL_QUORUM --threads=1 --replication-strategy=NetworkTopologyStrategy --strategy-properties=us-east:2,us-west:2 --column-size=192 --keep-going --num-keys=10000 -r  > /opt/cassandra/tools/results/112_vcider-0.4.0_MultiDC_EncryptionOFF_T-1_C-LOCAL_QUORUM_R-2_R_2_B-192.log 2>&1
/opt/cassandra/tools/stress/bin/autocommit.sh > /var/log/autocommit.log 2>&1
sleep 120

time  ./autorun_tests_multidc.sh --consistency-level=LOCAL_QUORUM --threads=1 --replication-strategy=NetworkTopologyStrategy --strategy-properties=us-east:2,us-west:2 --column-size=128 --keep-going --num-keys=10000 -r  > /opt/cassandra/tools/results/112_vcider-0.4.0_MultiDC_EncryptionOFF_T-1_C-LOCAL_QUORUM_R-2_R_2_B-128.log 2>&1
/opt/cassandra/tools/stress/bin/autocommit.sh > /var/log/autocommit.log 2>&1
sleep 120

time ./autorun_tests_multidc.sh --consistency-level=LOCAL_QUORUM --threads=1 --replication-strategy=NetworkTopologyStrategy --strategy-properties=us-east:2,us-west:2 --column-size=64 --keep-going --num-keys=10000 -r > /opt/cassandra/tools/results/112_vcider-0.4.0_MultiDC_EncryptionOFF_T-1_C-LOCAL_QUORUM_R-2_R_2_B-64.log 2>&1
/opt/cassandra/tools/stress/bin/autocommit.sh > /var/log/autocommit.log 2>&1
sleep 120

time ./autorun_tests_multidc.sh --consistency-level=LOCAL_QUORUM --threads=1 --replication-strategy=NetworkTopologyStrategy --strategy-properties=us-east:2,us-west:2 --column-size=32 --keep-going --num-keys=10000  -r > /opt/cassandra/tools/results/112_vcider-0.4.0_MultiDC_EncryptionOFF_T-1_C-LOCAL_QUORUM_R-2_R_2_B-32.log 2>&1
/opt/cassandra/tools/stress/bin/autocommit.sh > /var/log/autocommit.log 2>&1
sleep 120

###############################

exit 0
