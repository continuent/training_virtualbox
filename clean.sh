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

for SERVER in host1 host2 host3 host4
        do
          echo "*  Cleaning       $SERVER                                  "

          ssh $SERVER "/opt/continuent/tungsten/cluster-home/bin/stopall &> /dev/null;rm -rf /opt/continuent/{backups,conf,relay,releases,service_logs,share,thl,tungsten,multi-master} &> /dev/null" &


          mysql -P3306 -e"drop database test" -h $SERVER -u tungsten -psecret &> /dev/null
          mysql -P3306 -e"drop database tungsten_cluster" -h $SERVER -u tungsten -psecret &> /dev/null
          mysql -P3306 -e"drop database tungsten_east" -h $SERVER -u tungsten -psecret &> /dev/null
          mysql -P3306 -e"drop database tungsten_west" -h $SERVER -u tungsten -psecret &> /dev/null
          mysql -P3306 -e"create database test" -h $SERVER -u tungsten -psecret &> /dev/null
          mysql -P3306 -e"set global read_only=0" -h $SERVER -u tungsten -psecret &> /dev/null
          mysql -P3306 -e"stop slave;reset slave all" -h $SERVER -u tungsten -psecret &> /dev/null

          for d in $(mysql -P3306 -h $SERVER -u tungsten -psecret --batch --column-names=false -e "select schema_name from information_schema.schemata where schema_name like 'tungsten_%'");
          do
            mysql -P3306 -e"drop database $d" -h $SERVER -u tungsten -psecret &> /dev/null
          done
        done

        #Just pause to ensure the background shutdowns have completed
        sleep 20