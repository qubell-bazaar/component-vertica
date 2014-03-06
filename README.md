vertica
=======

![](http://www.vertica.com/wp-content/themes/vertica/images/img-vertica-logo.png)

Installs and configures [HP Vertica](http://www.vertica.com/) Community Edition.

[![Install](https://raw.github.com/qubell-bazaar/component-skeleton/master/img/install.png)](https://express.qubell.com/applications/upload?metadataUrl=https://github.com/qubell-bazaar/component-vertica/raw/master/meta.yml)

Features
--------
 - Install and configure HP Vertica in cluster configuration (configurable number of nodes)
 - Install and configure HP Vertica Management Console

Configurations
--------------
 - HP Vertica 7.0, CentOS 6.3 (us-east-1/ami-eb6b0182), AWS EC2 m3.medium, root
 - HP Vertica 7.0, official HP Vertica AMI, AWS EC2 m3.medium, root
 
Pre-requisites
--------------
 - Configured Cloud Account a in chosen environment
 - Either installed Chef on target compute OR launch under root
 - Internet access from target compute:
  - If installing from base OS: HP Vertica distibution: setup URL to the RPM in configuration (CentOS)
  - If installing Management Console: HP Vertica Management Console distibution: setup the URL to RPM in configuration (CentOS)
  - S3 bucket with Chef recipes: ** (TBD)
  - If Chef is not installed: ** (TBD)
 - Vertica license key

Implementation notes
--------------------
 - Installation is based on Chef recipes from **

Example usage
-------------
**
