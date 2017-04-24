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
  include_recipe 'java'
end

include_recipe 'runit'

# ark requires rsync package
package %w(unzip rsync)


user node['artifactory_ii']['user'] do
  home node['artifactory_ii']['home']
end

dir = [
  node['artifactory_ii']['home'],
  node['artifactory_ii']['catalina_base'],
  %w(work temp).each { |tomcat_dir| ::File.join(node['artifactory_ii']['catalina_base'], tomcat_dir) },
  node['artifactory_ii']['log_dir']
]

dir.each do |folder|
  directory folder do
    owner node['artifactory_ii']['user']
    mode 00755
    recursive true
  end

end

ark 'artifactory' do
  url node['artifactory_ii']['zip_url']
  checksum node['artifactory_ii']['zip_checksum']
  action :install
end

links = [
  { ::File.join(node['artifactory_ii']['home'], 'webapps') => '/usr/local/artifactory/webapps' },
  { ::File.join(node['artifactory_ii']['catalina_base'], 'logs') => node['artifactory_ii']['log_dir'] },
  { ::File.join(node['artifactory_ii']['catalina_base'], 'conf') => '/usr/local/artifactory/tomcat/conf' }
]

links.each do |folder, folder2|
  link folder do
    to folder2
  end
end

template '/usr/local/artifactory/tomcat/conf/server.xml' do
  mode 00644
  notifies :restart, 'runit_service[artifactory]'
end

runit_service 'artifactory'
