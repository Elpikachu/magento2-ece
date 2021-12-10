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
```platform variable:create -p <your Platform.sh projectID> --level project --name env:COMPOSER_AUTH --json true --visible-runtime false --sensitive true --visible-build true  --value '{"http-basic":{"repo.magento.com":{"username":"[public key]","password":"[private key]"}}}'
```
The first deploy will fail because the variable will not be taken into account. The only way to have it work on the first try is to includ an auth.json file with your credentials in it (highly not recommanded though).
### Blackfire setup
In order to showcase blackfire during your demo, you'll need to create the associated variables.
Log into your Blackfire account and follow this documentation: https://blackfire.io/docs/up-and-running/installation
Note that you'll need to use the "server" and "Platform.sh" to get the variables command ready to use.

## How to run
### Admin access
There is no admin user existing, as such, you cannot login in Magento backoffice.
To create one, SSH to the app container and use the following command: `php bin/magento admin:user:create`.  
The login will then happen on the `/admin` URL of the site.
## Disabling TFA
In order to have an easier back office access, you can disable TFA by connecting through SSH to the app container and run:
```
bin/magento config:set twofactorauth/general/enable 0
```

### Site performance
In order to have a quick deploy time for showcases, we have put the SCD on demand, which means that the first access will be slow. Please take a moment to do some cache warming before the demo

## Differences with Vanilla Magento
We have added some patches packages in order to have a clean install.
We also added the ECE tools, which is a set of tools that help in building and deploying Magento 2 on Platform.sh.
The ECE tools configuration is partly managed by the `.magento.env.yaml` file in the Git repo. The build and deploy scenarios can be found in the associated vendor directory.
