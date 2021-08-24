## Introduction

This helm chart deploys an instance of MongoDB using the KubeDB and Stash operators by AppsCode. These operators simplify the deployment, maintenance and backup of databases on Kubernetes.

## Details

The following resources could be created:

* MongoDB instance
* NetworkPolicy allowing access to the MongoDB instance
* Service allowing access to MongoDB from inside the Kubernetes cluster
* MongoDB backup process with Stash (if enabled)

## Prerequisites

This chart is currently supported on:

* OpenShift 4.7
* KubeDB v.2021.06.23
* Stash v.2021.08.02

## Chart Parameters

| Parameter | Description |
| --------- | ----------- |
| `mongodb.spec.version` | The version of MongoDB to deploy. Defaults to `4.2.3`. May be one of `4.0.11-v1`, `4.2.3`, `4.4.6`. |
| `mongodb.spec.storage.size` | The amount of storage to allocate for the MongoDB database. Defaults to `1Gi`. |
| `mongodb.spec.authSecret` | An already existing set of credentials to use for the MOngoDB superuser account. If not provided, the operator will create credentials for use. |
| `mongodb.spec.terminationPolicy` | Termination policy for the instance when MongoDB is removed. Defaults to `WipeOut`. May be one of: `Delete`, `DoNotTerminate`, `Halt`, or `WipeOut`. |
| `mongodb.spec.resources.limits.cpu` | Maximum amount of CPU that a container may consume. Defaults to `1`. |
| `mongodb.spec.resources.limits.memory` | Maximum amount of memory that a container may consume. Defaults to `1Gi`. |
| `mongodb.spec.resources.requests.cpu` | Minimum amount of CPU that a container is allocated. Defaults to `500m`. |
| `mongodb.spec.resources.requests.memory` | Minimum amount of memory that a container is allocated. Defailts to `512Mi`. |
| `stash.enabled` | Whether or not to enable backups of MongoDB using Stash. Defaults to `false`. |
| `stash.restic_password` | Password used to encrypt the backups. If not specified, one will be automatically created. |
| `stash.retention_policy.name` | Descriptive name of the retention policy for backups. Defaults to `keep-last-5`. |
| `stash.retention_policy.keep` | Number of backups to retain. Defaults to `five`. |
| `stash.retention_policy.prune` | Whether or not to cleanup unreferenced data. Defaults to `true`. |
| `stash.schedule` | Cron schedule for performing the backups. Defaults to `11 5 * * *` |
| `stash.storage_size` | Storage to allocate for holding backups. Defaults to `1Gi`.

## Advanced Configuration

The KubeDB and MongoDB operators offer many other configuration capabilities
not currently exposed in this chart. For details on what is possible, see:


* [https://kubedb.com/docs/v2021.06.23/welcome/](https://kubedb.com/docs/v2021.06.23/welcome/}
* [https://stash.run/docs/v2021.08.02/guides/latest/](https://stash.run/docs/v2021.08.02/guides/latest/)

Please contact the Platforms Team to request the addition of a capability
with this offering.
