#
# Cookbook:: artifactory_ii
# Recipe:: default
#
# Copyright:: 2017, Corey Hemminger
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if node['artifactory_ii']['install_java']
  node.set['java']['jdk_version'] = 7
  include_recipe 'java'
end

include_recipe 'runit'
package 'unzip'
# ark requires rsync package
package 'rsync'

user node['artifactory_ii']['user'] do
  home node['artifactory_ii']['home']
end

directory node['artifactory_ii']['home'] do
  owner node['artifactory_ii']['user']
  mode 00755
  recursive true
end

directory node['artifactory_ii']['catalina_base'] do
  owner node['artifactory_ii']['user']
  mode 00755
  recursive true
end

%w(work temp).each do |tomcat_dir|
  directory ::File.join(node['artifactory_ii']['catalina_base'], tomcat_dir) do
    owner node['artifactory_ii']['user']
    mode 00755
  end
end

directory node['artifactory_ii']['log_dir'] do
  owner node['artifactory_ii']['user']
  mode 00755
end

ark 'artifactory' do
  url node['artifactory_ii']['zip_url']
  checksum node['artifactory_ii']['zip_checksum']
  action :install
end

link ::File.join(node['artifactory_ii']['home'], 'webapps') do
  to '/usr/local/artifactory/webapps'
end

link ::File.join(node['artifactory_ii']['catalina_base'], 'logs') do
  to node['artifactory_ii']['log_dir']
end

link ::File.join(node['artifactory_ii']['catalina_base'], 'conf') do
  to '/usr/local/artifactory/tomcat/conf'
end

template '/usr/local/artifactory/tomcat/conf/server.xml' do
  mode 00644
  notifies :restart, 'runit_service[artifactory]'
end

runit_service 'artifactory'
