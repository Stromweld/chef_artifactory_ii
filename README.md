# artifactory_ii

Installs JFrog's Artifactory

## Requirements

* Java 7 (java cookbook)
* ark cookbook
depends          'runit'
depends          'apache2'

## Usage

This cookbook doesn't configure Artifactory since Artifactory was designed primarily for configuration from the UI. It's possible to bootstrap Artifactory's configuration by copying an existing configuration to `$ARTIFACTORY_HOME/etc/artifactory.config.import.xml`. A configuration file can be obtained from a running Artifactory server using curl:

	curl -u admin:password -X GET -H 'Accept: application/xml' http://localhost:8081/artifactory/api/system/configuration

Refer to [Artifactory user guide](http://wiki.jfrog.org/confluence/display/RTF/Global+Configuration+Descriptor) for more details

The default username/password for the server is admin/password

## Attributes

* `node['artifactory_ii']['home']` - Artifactory home directory. Artifacts are kept here
* `node['artifactory_ii']['log_dir']` - Artifactory/tomcat logs
* `node['artifactory_ii']['port']` - Artifactory http port, default is 8081
* `node['artifactory_ii']['shutdown_port']` - Artifactory http port, default is 8081
* `node['artifactory_ii']['java']['xmx']` - java Xmx (max heap size)
* `node['artifactory_ii']['java']['xms']` - java Xms (initial heap size)
* `node['artifactory_ii']['java']['extra_opts']` - Extra java options, default is '-XX:+UseG1GC'
* `node['artifactory_ii']['install_java']` - Instruct this cookbook to install Java for you. Default `true`


## Recipes

* artifactory_ii::default - Installs Artifactory
* artifactory_ii::apache_proxy - Setup Apache reverse proxy in front of Artifactory

## Author

* Author:: Avishai Ish-Shalom (<avishai@fewbytes.com>)
* Author:: Eric Helgeson (<erichelgeson@gmail.com>)
