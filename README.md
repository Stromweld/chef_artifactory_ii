# artifactory_ii

Installs JFrog's Artifactory

Cookbook copied from Agileorbit [artifactory cookbook](https://supermarket.chef.io/cookbooks/artifactory). This cookbook has been updated to support chef-client 13+.

## Requirements

* Java cookbook
* ark cookbook
* runit cookbook
* apache2 cookbook

## Usage

This cookbook doesn't configure Artifactory since Artifactory was designed primarily for configuration from the UI. It's possible to bootstrap Artifactory's configuration by copying an existing configuration to `$ARTIFACTORY_HOME/etc/artifactory.config.import.xml`. A configuration file can be obtained from a running Artifactory server using curl:

	curl -u admin:password -X GET -H 'Accept: application/xml' http://localhost:8081/artifactory/api/system/configuration

Refer to [Artifactory user guide](http://wiki.jfrog.org/confluence/display/RTF/Global+Configuration+Descriptor) for more details

The default username/password for the server is admin/password

## Attributes

| Attribute | Default | Comment |
| -------------  | -------------  | -------------  |
| ['artifactory_ii']['zip_url'] | 'http://dl.bintray.com/content/jfrog/artifactory/artifactory-3.4.1.zip?direct' | String, Download url |
| ['artifactory_ii']['zip_checksum'] | '5019e4a4cac7936b3d4e1fc457d36fff60cdf27de42886184b0b5a844f43f0b0' | String, sha 256 sum of download file |
| ['artifactory_ii']['home'] | '/var/lib/artifactory' | String, artifactory home directory location |
| ['artifactory_ii']['log_dir'] | '/var/log/artifactory' | String, artifactory log file location |
| ['artifactory_ii']['catalina_base'] | ::File.join(node['artifactory_ii']['home'], 'tomcat') | String, location of the install directory |
| ['artifactory_ii']['java']['xmx'] | '1g' | String, maximum memory assigned to the java process |
| ['artifactory_ii']['java']['xms'] | '512m' | Stirng, minimum memory assigned to the java process |
| ['artifactory_ii']['java']['extra_opts'] | '-XX:+UseG1GC' | String, additional java tuning options to pass to the process |
| ['artifactory_ii']['user'] | 'artifactory' | String, user account to run the process under |
| ['artifactory_ii']['port'] | 8081 | Integer, port for artifactory to listen on |
| ['artifactory_ii']['shutdown_port'] | 8015 | Integer, port to listen for shutdown command | 
| ['artifactory_ii']['install_java'] | true | boolean, have artifactory cookbook install java |

## Recipes

* artifactory_ii::default - Installs Artifactory
* artifactory_ii::apache_proxy - Setup Apache reverse proxy in front of Artifactory

## Author

* Author:: Avishai Ish-Shalom (<avishai@fewbytes.com>)
* Author:: Eric Helgeson (<erichelgeson@gmail.com>)
* Author:: Corey Hemminger (<hemminger@hotmail.com>)
