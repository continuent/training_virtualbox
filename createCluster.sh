cd /opt/continuent/software/continuent*
rm deploy.cfg
tools/tpm install cluster  \
--user=tungsten \
--home-directory=/opt/continuent \
--dataservice-hosts=host1,host2,host3 \
--dataservice-connectors=host1,host2,host3 \
--dataservice-master-host=host1 \
--mysql-connectorj-path=/opt/mysql/mysql-connector-java-5.1.21/mysql-connector-java-5.1.21-bin.jar \
--datasource-user=tungsten \
--datasource-password=secret \
--profile-script="~/.bash_profile" \
--start-and-report \
--application-user=appuser \
--application-password=password \
--connector-smartscale=true --connector-smartscale-sessionid=DATABASE