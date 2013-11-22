#!/bin/bash
# === Copyright
#
# Copyright 2013 Continuent Inc.
#
# === License
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
echo "Backing up host3"
mysqldump -h host3 -P3306 -u tungsten -psecret --all-databases --events > /tmp/newNode.dmp

echo "Restoring host3 backup into host4"
mysql -P3306 -h host4 -u tungsten -psecret < /tmp/newNode.dmp


cd /opt/continuent/software/continuent*

tools/tpm configure cluster --dataservice-hosts=host1,host2,host3,host4 --dataservice-connectors=host1,host2,host3,host4
tools/tpm update cluster

rm /tmp/newNode.dmp