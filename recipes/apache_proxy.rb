#
# Cookbook:: artifactory_ii
# Recipe:: apache_proxy
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

include_recipe 'artifactory_ii'
include_recipe 'apache2'
include_recipe 'apache2::mod_proxy_http'

host_name = node['artifactory_ii']['host_name'] || node['fqdn']

template "#{node['apache']['dir']}/sites-available/artifactory" do
  source 'apache-artifactory-vhost.conf.erb'
  owner       'root'
  group       'root'
  mode        '0644'
  variables(
    host_name: host_name
  )

  if File.exists?("#{node['apache']['dir']}/sites-enabled/artifactory")
    notifies  :restart, 'service[apache2]'
  end
end

apache_site 'artifactory' do
  enable true
end
