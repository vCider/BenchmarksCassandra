#!/bin/bash

# Wait for first batch to get over. Sleep for 10 minutes if the run is in progress. 
while [  `pgrep batch2.sh` ]
do
   echo "I: BATCH 1 IN PROGRESS"
   sleep 600
done
   echo "I: Launching Batch 2..."


time ./autorun_tests2.sh --consistency-level=ONE --threads=40 --replication-factor=1 --column-size=32 --keep-going --num-keys=500000  -r > /opt/cassandra/tools/results/006_vcider-0.4.0_SingleDC_EncryptionON_C-ONE_R-1_B-32.log 2>&1
/opt/cassandra/tools/stress/bin/autocommit.sh > /var/log/autocommit.log 2>&1
sleep 120


time ./autorun_tests2.sh --consistency-level=ONE --threads=40 --replication-factor=1 --column-size=64 --keep-going --num-keys=500000 -r > /opt/cassandra/tools/results/006_vcider-0.4.0_SingleDC_EncryptionON_C-ONE_R-1_B-64.log 2>&1
/opt/cassandra/tools/stress/bin/autocommit.sh > /var/log/autocommit.log 2>&1
sleep 120

time  ./autorun_tests2.sh --consistency-level=ONE --threads=40 --replication-factor=1 --column-size=128 --keep-going --num-keys=500000 -r  > /opt/cassandra/tools/results/006_vcider-0.4.0_SingleDC_EncryptionON_C-ONE_R-1_B-128.log 2>&1
/opt/cassandra/tools/stress/bin/autocommit.sh > /var/log/autocommit.log 2>&1
sleep 120

time ./autorun_tests2.sh --consistency-level=ONE --threads=40 --replication-factor=1 --column-size=192 --keep-going --num-keys=500000 -r  > /opt/cassandra/tools/results/006_vcider-0.4.0_SingleDC_EncryptionON_C-ONE_R-1_B-192.log 2>&1
/opt/cassandra/tools/stress/bin/autocommit.sh > /var/log/autocommit.log 2>&1
sleep 120

time ./autorun_tests2.sh --consistency-level=ONE --threads=40 --replication-factor=1 --column-size=256 --keep-going --num-keys=500000 -r  > /opt/cassandra/tools/results/006_vcider-0.4.0_SingleDC_EncryptionON_C-ONE_R-1_B-256.log 2>&1
/opt/cassandra/tools/stress/bin/autocommit.sh > /var/log/autocommit.log 2>&1




exit 0
