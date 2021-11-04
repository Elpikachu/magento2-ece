# Magento 2 Community Edition on Platform.sh

This template permits to build Magento 2 CE on PSH and showcase the build, deploy and management of the application.
The application is configured to use the following services & runtimes:
* MariaDB
* Redis
* Elasticsearch
* RabbitMQ
* PHP 7.4

With the help of some additional packages, like the ece-tools, the deploy becomes easier and faster.

## How to prepare
### Magento repo authentication
The access to the Magento repo needs you to authenticate before pulling the code.
You'll need to have a Magento account (free) in order to use this template.
Once you have your account, create a project level variable in JSON format with your auth informations: 
`platform variable:create -p <your Platform.sh projectID> --level project --name env:COMPOSER_AUTH --json true --visible-runtime false --sensitive true --visible-build true  --value '{"http-basic":{"repo.magento.com":{"username":"[public key]","password":"[private key]"}}}'`

### Blackfire setup
In order to showcase blackfire during your demo, you'll need to create the associated variables.
Log into your Blackfire account and follow this documentation: https://blackfire.io/docs/up-and-running/installation
Note that you'll need to use the "server" and "Platform.sh" to get the variables command ready to use.

## How to run
### After first deploy
There is no admin user existing, as such, you cannot login in Magento backoffice.
To create one, SSH to the app container and use the following command: `php bin/magento admin:user:create`.  
The login will then happen on the `/admin` URL of the site.

## Customizations

The following changes have been made relative to Magento 2 as it is downloaded from Magento.com.  If using this project as a reference for your own existing project, replicate the changes below to your project.

* The `.platform.app.yaml`, `.platform/services.yaml`, and `.platform/routes.yaml` files have been added.  These provide Platform.sh-specific configuration and are present in all projects on Platform.sh.  You may customize them as you see fit.
* The `composer.json` file has had the ECE-Tools package and its dependencies added.
* Magento crons have been setup to ensure they are run sequentially to ensure there is availible memory
