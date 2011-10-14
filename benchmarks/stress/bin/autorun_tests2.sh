#!/bin/bash

STRESS_OPTIONS=""

STRESS_OPTIONS=$@

#Iterate 10 times
for i in $(seq 1 10)

do
  echo "======================================================================================"
  echo "ITERATION $i"
  echo "======================================================================================"

  echo "I: Activating vCider beta cluster.."
  ssh -i /home/ubuntu/vcider-cal.pem ubuntu@50.18.181.61 "sudo cp /etc/puppet/manifests/nodes.pp.2 /etc/puppet/manifests/nodes.pp"

  echo "I: stopping cassandra.."
  for hosts in `cat nodes.1`; do ssh -i /home/ubuntu/vcider-sg.pem ubuntu@$hosts "sudo /etc/init.d/cassandra stop  >/dev/null"; done
  echo "I: cleaning up  cassandra files.."
  for hosts in `cat nodes.1`; do ssh -i /home/ubuntu/vcider-sg.pem ubuntu@$hosts "sudo rm -rf /mnt/cassandra/*"; done

  echo "I: updating puppet configs.."
  for hosts in `cat nodes.1`; do ssh -i /home/ubuntu/vcider-sg.pem ubuntu@$hosts "sudo puppetd --test >/dev/null"; done
  sleep 5
  for hosts in `cat nodes.1`; do ssh -i /home/ubuntu/vcider-sg.pem ubuntu@$hosts "sudo puppetd --test >/dev/null"; done

  sleep 2
  echo "I: starting cassandra.."
  for hosts in `cat nodes.1`; do  ssh -i /home/ubuntu/vcider-sg.pem ubuntu@$hosts "sudo /etc/init.d/cassandra start >/dev/null 2>&1"; done

  #echo "I: sleeping for one minute.."
  sleep 5
  #echo "I: Ring Status before Test Run:"
  #ssh -i /home/ubuntu/vcider-sg.pem ubuntu@`head -n1 nodes` "sudo /opt/cassandra/bin/nodetool -h localhost ring" 

  #echo "I: Running preTEST run with default options.."
  #./stress -D nodes.1 -i 1000 --num-keys=100000 -k
  #echo "I: Completed running preTEST, sleeping for 30 seconds"
  #sleep 5
  #echo "I: Ring status after preTEST"
  echo "I: Ring Status" 
  ssh -i /home/ubuntu/vcider-sg.pem ubuntu@`head -n1 nodes.1` "sudo /opt/cassandra/bin/nodetool -h localhost ring"

  for hosts in `cat nodes.1`; do  ssh -i /home/ubuntu/vcider-sg.pem ubuntu@$hosts "sudo /etc/init.d/cassandra start >/dev/null 2>&1"; done

  echo "I: Running Test Case with Options: $STRESS_OPTIONS"
  #echo "Options: $STRESS_OPTIONS"
  ./stress -D  nodes2 $STRESS_OPTIONS | tee tmp

  array[i]=`cat tmp | grep ^[0-9].* | tail -n1 |  awk '$0=$NF' FS=","`

  #echo "I: sleeping for one minute.."
  sleep 10

  echo "I: Ring Status after Test Run:"
  ssh -i /home/ubuntu/vcider-sg.pem ubuntu@`head -n1 nodes.1` "sudo /opt/cassandra/bin/nodetool -h localhost ring" 


  echo "I: Activating Ec2 Native cluster.."
  ssh -i /home/ubuntu/vcider-cal.pem ubuntu@50.18.181.61 "sudo cp /etc/puppet/manifests/nodes.pp.3 /etc/puppet/manifests/nodes.pp"

  echo "I: stopping cassandra.."
  for hosts in `cat nodes.1`; do ssh -i /home/ubuntu/vcider-sg.pem ubuntu@$hosts "sudo /etc/init.d/cassandra stop >/dev/null"; done
  echo "I: cleaning up  cassandra files.."
  for hosts in `cat nodes.1`; do ssh -i /home/ubuntu/vcider-sg.pem ubuntu@$hosts "sudo rm -rf /mnt/cassandra/*"; done
  #for hosts in `cat nodes`; do ssh -i /home/ubuntu/vcider-sg.pem ubuntu@$hosts "sudo /etc/init.d/cassandra start"; done                           
  echo "I: updating puppet configs.."
  for hosts in `cat nodes.1`; do ssh -i /home/ubuntu/vcider-sg.pem ubuntu@$hosts "sudo puppetd --test >/dev/null"; done
  sleep 5
  for hosts in `cat nodes.1`; do ssh -i /home/ubuntu/vcider-sg.pem ubuntu@$hosts "sudo puppetd --test >/dev/null"; done

  sleep 2
  echo "I: starting cassandra.."
  for hosts in `cat nodes.1`; do  ssh -i /home/ubuntu/vcider-sg.pem ubuntu@$hosts "sudo /etc/init.d/cassandra start >/dev/null 2>&1"; done

  #echo "I: sleeping for one minute.."
  sleep 5

  #echo "I: Ring Status before Test Run:"
  #ssh -i /home/ubuntu/vcider-sg.pem ubuntu@`head -n1 nodes` "sudo /opt/cassandra/bin/nodetool -h localhost ring"

  #echo "I: Running preTEST run with default options.."
  #./stress -D nodes.1 -i 1000 --num-keys=100000 -k
  #echo "I: Completed running preTEST, sleeping for 30 seconds"

  #sleep 5
  #echo "I: Ring status after preTEST"
  ssh -i /home/ubuntu/vcider-sg.pem ubuntu@`head -n1 nodes.1` "sudo /opt/cassandra/bin/nodetool -h localhost ring"

  for hosts in `cat nodes.1`; do  ssh -i /home/ubuntu/vcider-sg.pem ubuntu@$hosts "sudo /etc/init.d/cassandra start >/dev/null 2>&1"; done
  
  echo "I: Running Test Case with Options:$STRESS_OPTIONS"
  #echo "Options: $STRESS_OPTIONS"
  #./get_openvpn_ips.sh
  ./stress -D nodes.1 $STRESS_OPTIONS | tee tmp

  array2[i]=`cat tmp | grep ^[0-9].* | tail -n1 | awk '$0=$NF' FS=","`

  #echo "I: sleeping for one minute.."
  sleep 10

  echo "I: Ring Status after Test Run:"
  ssh -i /home/ubuntu/vcider-sg.pem ubuntu@`head -n1 nodes.1` "sudo /opt/cassandra/bin/nodetool -h localhost ring"

  echo "======================================================================================"


done

  echo "======================================================================================"
  echo "RESULTS SUMMARY"
  echo "======================================================================================"
  echo "TEST PARAMETERS: $STRESS_OPTIONS"

  echo "Total elapsed times for vCider Cluster:"
  echo "----------------------------------------"
  echo "  Iteration    |  vCider  |  Ec2 Native "
  echo "----------------------------------------"

  for i in $(seq 1 10)  
  do
    echo "       $i           ${array[i]}         ${array2[i]}  "
  done

  echo "----------------------------------------"


#  echo "Total elapsed times for EC2MultiRegionSnitch Cluster:"
#  for i in $(seq 1 10)
#  do
#    echo "Iteration $i:  ${array2[i]} seconds"
#  done

#  echo "======================================================================================"
  echo "DONE"
  exit 0
