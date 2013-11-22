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