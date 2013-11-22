echo "Backing up host3"
mysqldump -h host3 -P3306 -u tungsten -psecret --all-databases --events > /tmp/newNode.dmp

echo "Restoring host3 backup into host4"
mysql -P3306 -h host4 -u tungsten -psecret < /tmp/newNode.dmp


cd /opt/continuent/software/continuent*

tools/tpm configure cluster --dataservice-hosts=host1,host2,host3,host4 --dataservice-connectors=host1,host2,host3,host4
tools/tpm update cluster

rm /tmp/newNode.dmp