#!/bin/bash
echo "stopping cassandra.."
for hosts in `cat nodes`; do echo $hosts; ssh -i /home/ubuntu/vcider.pem ubuntu@$hosts "sudo /etc/init.d/cassandra stop"; done
echo "cleaning up  cassandra files.."
for hosts in `cat nodes`; do echo $hosts; ssh -i /home/ubuntu/vcider.pem ubuntu@$hosts "sudo rm -rf /var/lib/cassandra/*"; done
echo "starting up cassandra.."
for hosts in `cat nodes`; do echo $hosts; ssh -i /home/ubuntu/vcider.pem ubuntu@$hosts "sudo /etc/init.d/cassandra start"; done
#for hosts in `cat nodes`; do echo $hosts; ssh -i /home/ubuntu/vcider.pem ubuntu@$hosts "sudo puppetd --test"; done
echo "DONE"

exit 0
