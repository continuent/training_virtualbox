training_virtualbox
===================

Training Images and scripts for Continuent Tungsten using virtualbox images.


Download and extract the 4 Virtual box images

https://s3.amazonaws.com/vms.continuent.com/mysqlconf2013/host_1.zip
https://s3.amazonaws.com/vms.continuent.com/mysqlconf2013/host_2.zip
https://s3.amazonaws.com/vms.continuent.com/mysqlconf2013/host_3.zip
https://s3.amazonaws.com/vms.continuent.com/mysqlconf2013/host_4.zip

The are set up to use a private host-only network and host1 can be accessed from the machine running virtual box via the command - The password is 'password'.
Increase the memory if you have more available on the host machine they are currently setup with 512MB each


ssh -p 2222 tungsten@localhost


Download the latest release of Continuent Tungsten from the Downloads section of www.continuent.com and upload to /opt/continuent/software


Snapshot all 4 images at this point to get a roll back point


To install a basic cluster copy createCluster.sh to host1 and run it

createCluster.sh

To pick up the new profile

source ~.bash_profile

The run cctrl to look at the cluster status

To reset the hosts back to their clean state run the command

clean.sh

To add a new node and connector on node4 run

addNode.sh


