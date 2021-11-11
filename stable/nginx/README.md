## Introduction

This helm chart deploys an instance of Nginx to mount CCS directories and serve static files out of the www subdirectory.

## Prerequisites

This chart requires to be deployed to the marble or onyx clusters with the expectation of a www subdirectory for hosting static files.

This chart is currently supported on:

* OpenShift 4.7

## Chart Parameters

| Parameter | Default Value | Description |
| --------- | ----------- | ----------- |
| replicaCount | `1` | Replicas of the pod to run |
| ccsFs | `olcf` | Filesystem to to mount to the nginx pod, optionally `ccsopen` |
| image.repository | `nginxinc/nginx-unprivileged` | Nginx image repository |
| image.pullPolicy | `IfNotPresent` | Nginx image tag |
| imagePullSecrets | `[]` | Pull secrets for running the container |
| serviceAccount.create | `true` | Service account created to run the pod |
| serviceAccount.annotations | `{}` | Pod annotations for the running pod |
| serviceAccount.name | `""` | Overrride for the service account name |
| podAnnotations | `{}` | Annotations to be added to the pod on creation |
| service.type | `ClusterIP` | Type of service object, optionally `NodePort` |
| service.port | `8080` | Port to expose for cluster traffic |
| ingress.enabled | `false` | Create a route object to expose traffic outside cluster |
| ingress.external | `false` | Create a route object to expose traffic to the internet |
| ingress.domain | `ccs.ornl.gov` | Domain the route will be created with |
| ingress.cluster | `marble` | Cluster the host URL will be created with |
| ingress.hostOverride | `""` | Override the default URL format with custom domain |
| ingress.annotations | `ccs.ornl.gov/requireAuth: 'true'` | Route ingress annotations |
| resources.limits.cpu | `500m` | Nginx default cpu limit allocation |
| resources.limits.memory | `2Gi` | Nginx default memory limit allocation |
| resources.requests.cpu | `500m` | Nginx default cpu requests allocation |
| resources.requests.memory | `2Gi` | Nginx default memory requests allocation |
| autoscaling.enabled | `false` | Enables an HPA to be created |
| autoscaling.minReplicas | `1` | Minimum replica count during autoscaling |
| autoscaling.maxReplicas | `10` | Maximum replica count during autoscaling |
| autoscaling.targetCPUUtilizationPercentage | `80` | CPU percentage to trigger autoscaling |
| autoscaling.nodeSelector | `{}` | Run nginx on specific nodes |
| autoscaling.tolerations | `[]` | Tolerations to support during scheduling |
| autoscaling.affinity | `{}` | Affinity settings for the nginx pod |

## Advanced Configuration

This project uses the NGINX Unprivileged Docker Image. For more information follow link below:

* [https://github.com/nginxinc/docker-nginx-unprivileged](https://github.com/nginxinc/docker-nginx-unprivileged}

Please contact the Platforms Team to request the addition of a capability
with this offering.
