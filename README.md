[![Chef cookbook](https://img.shields.io/cookbook/v/artifactory_ii.svg)]()
[![Code Climate](https://codeclimate.com/github/Stromweld/artifactory_ii/badges/gpa.svg)](https://codeclimate.com/github/Stromweld/artifactory_ii)
[![Issue Count](https://codeclimate.com/github/Stromweld/artifactory_ii/badges/issue_count.svg)](https://codeclimate.com/github/Stromweld/artifactory_ii)

# artifactory_ii

Installs JFrog's Artifactory

Cookbook partially copied from Agileorbit [artifactory cookbook](https://supermarket.chef.io/cookbooks/artifactory). This cookbook has been updated to support chef-client 13+ and install artifactory from yum repo.

## Requirements

* Java cookbook
* apache2 cookbook

## Usage

This cookbook doesn't configure Artifactory since Artifactory was designed primarily for configuration from the UI. It's possible to bootstrap Artifactory's configuration by copying an existing configuration to `$ARTIFACTORY_HOME/etc/artifactory.config.import.xml`. A configuration file can be obtained from a running Artifactory server using curl:

	curl -u admin:password -X GET -H 'Accept: application/xml' http://localhost:8081/artifactory/api/system/configuration

Refer to [Artifactory user guide](http://wiki.jfrog.org/confluence/display/RTF/Global+Configuration+Descriptor) for more details

The default username/password for the server is admin/password

## Attributes

| Attribute | Default | Comment |
| -------------  | -------------  | -------------  |
| ['artifactory_ii']['java']['xmx'] | '1g' | String, maximum memory assigned to the java process |
| ['artifactory_ii']['java']['xms'] | '512m' | Stirng, minimum memory assigned to the java process |
| ['artifactory_ii']['java']['extra_opts'] | '-XX:+UseG1GC' | String, additional java tuning options to pass to the process |
| ['artifactory_ii']['install_java'] | true | boolean, have artifactory cookbook install java |

## Recipes

* artifactory_ii::default - Installs Artifactory
* artifactory_ii::apache_proxy - Setup Apache reverse proxy in front of Artifactory

## Author

* Author:: Avishai Ish-Shalom (<avishai@fewbytes.com>)
* Author:: Eric Helgeson (<erichelgeson@gmail.com>)
* Author:: Corey Hemminger (<hemminger@hotmail.com>)
