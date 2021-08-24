## Introduction

This helm chart deploys an instance of MySQL using the KubeDB and Stash operators by AppsCode. These operators simplify the deployment, maintenance and backup of databases on Kubernetes.

## Details

The following resources could be created:

* MySQL instance
* NetworkPolicy allowing access to the MySQL instance
* Service allowing access to MySQL from inside the Kubernetes cluster
* Deployment of phpMyAdmin configured to login to the MySQL instance
* Route to access the phpMyAdmin instance behind OpenShift OAUTH
* MySQL backup process with Stash (if enabled)

## Prerequisites

This chart is currently supported on:

* OpenShift 4.7
* KubeDB v.2021.06.23
* Stash v.2021.08.02

## Chart Parameters

| Parameter | Description |
| --------- | ----------- |
| `mysql.spec.version` | The version of MySQL to deploy. Defaults to `5.7.33-v1`. May be one of `5.7.33-v1`, `8.0.23-v1`. |
| `mysql.spec.storage.size` | The amount of storage to allocate for the MySQL database. Defaults to `1Gi`. |
| `mysql.spec.authSecret` | An already existing set of credentials to use for the MySQL root account. If not provided, the operator will create credentials for use. |
| `mysql.spec.terminationPolicy` | Termination policy for the instance when MySQL is removed. Defaults to `WipeOut`. May be one of: `Delete`, `DoNotTerminate`, `Halt`, or `WipeOut`. |
| `mysql.spec.configMapName` | Name of an existing configMap to run that initializes the MySQL database. |
| `mysql.spec.resources.limits.cpu` | Maximum amount of CPU that a container may consume. Defaults to `1`. |
| `mysql.spec.resources.limits.memory` | Maximum amount of memory that a container may consume. Defaults to `1Gi`. |
| `mysql.spec.resources.requests.cpu` | Minimum amount of CPU that a container is allocated. Defaults to `500m`. |
| `mysql.spec.resources.requests.memory` | Minimum amount of memory that a container is allocated. Defailts to `512Mi`. |
| `phpmyadmin.enabled` | Whether or not to deploy the phpMyAdmin web interface. Defaults to `true`. |
| `phpmyadmin.spec.resources.limits.cpu` | Maximum amount of CPU that a container may consume. Defaults to `1`. |
| `phpmyadmin.spec.resources.limits.memory` | Maximum amount of memory that a container may consume. Defaults to `1Gi`, |
| `phpmyadmin.spec.resources.requests.cpu` | Minimum amount of CPU that a container is allocated. Defaults to `500m`. |
| `phpmyadmin.spec.resources.requests.memory` | Minimum amount of memory that a container is allocated. Defailts to `512Mi`. |
| `phpmyadmin.apache2.port` | Port that apache2 will listen to for connections. Defaults to `8080`. |
| `phpmyadmin.auto_login` | Whether or not to configure automatic login into the interface. Defaults to `true`. |
| `phpmyadmin.blowfish_secret` | Custom blowfish secret to use for phpMyAdmin. Defaults to unspeficied and will be automatically generated. |
| `phpmyadmin.route.enabled` | Whether or not to enable the route to the phpMyAdmin instance. Defaults to `true`. |
| `phpmyadmin.route.hostname` | Hostname to use for the route. Default is not specified. |
| `phpmyadmin.tempdir_size` | Size for the phpMyAdmin tempdir. Defaults to `50Mi` |
| `phpmyadmin.user_config` | String that provides for any special configuration settings for phpMyAdmin. |`
| `stash.enabled` | Whether or not to enable backups of MySQL using Stash. Defaults to `true`. |
| `stash.restic_password` | Password used to encrypt the backups. If not specified, one will be automatically created. |
| `stash.retention_policy.name` | Descriptive name of the retention policy for backups. Defaults to `keep-last-5`. |
| `stash.retention_policy.keep` | Number of backups to retain. Defaults to `5`. |
| `stash.retention_policy.prune` | Whether or not to cleanup unreferenced data. Defaults to `true`. |
| `stash.schedule` | Cron schedule for performing the backups. Defaults to `11 5 * * * ` |
| `stash.storage_size` | Storage to allocate for holding backups. Defaults to `1Gi`.

## Advanced Configuration

The KubeDB and Stash operators offer many other configuration capabilities
not currently exposed in this chart. For details on what is possible, see:


* [https://kubedb.com/docs/v2021.06.23/welcome/](https://kubedb.com/docs/v2021.06.23/welcome/}
* [https://stash.run/docs/v2021.08.02/guides/latest/](https://stash.run/docs/v2021.08.02/guides/latest/)

Please contact the Platforms Team to request the addition of a capability
with this offering.
