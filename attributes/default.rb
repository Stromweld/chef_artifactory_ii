#
# Cookbook:: artifactory_ii
# Attributes:: default
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

default['artifactory_ii']['zip_url'] = 'http://dl.bintray.com/content/jfrog/artifactory/artifactory-3.4.1.zip?direct'
default['artifactory_ii']['zip_checksum'] = '5019e4a4cac7936b3d4e1fc457d36fff60cdf27de42886184b0b5a844f43f0b0'
default['artifactory_ii']['home'] = '/var/lib/artifactory'
default['artifactory_ii']['log_dir'] = '/var/log/artifactory'
default['artifactory_ii']['catalina_base'] = ::File.join(node['artifactory_ii']['home'], 'tomcat')
default['artifactory_ii']['java']['xmx'] = '1g'
default['artifactory_ii']['java']['xms'] = '512m'
default['artifactory_ii']['java']['extra_opts'] = '-XX:+UseG1GC'

default['artifactory_ii']['user'] = 'artifactory'
default['artifactory_ii']['port'] = 8081
default['artifactory_ii']['shutdown_port'] = 8015
default['artifactory_ii']['install_java'] = true
