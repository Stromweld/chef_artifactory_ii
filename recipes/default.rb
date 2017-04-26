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
  node.default['java']['install_flavor'] = 'oracle'
  node.default['java']['jdk_version'] = '8'
  node.default['java']['oracle']['accept_oracle_download_terms'] = true
  include_recipe 'java'
end

yum_repository 'artifactory' do
  description 'bintray-jfrog-artifactory repo'
  baseurl 'http://jfrog.bintray.com/artifactory-rpms'
  enabled true
  gpgcheck false
  repo_gpgcheck false
end

package 'jfrog-artifactory-oss'

template '/etc/opt/jfrog/artifactory/default' do
  source 'jvm_parameters.erb'
  owner 'artifactory'
  group 'artifactory'
  mode '0770'
  notifies :restart, 'service[artifactory]', :delayed
end

service 'artifactory' do
  action [:enable, :start]
end
