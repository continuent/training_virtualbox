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