# minio-nfs

[MinIO](https://min.io/) is a high performance, distributed object storage system. It is software-defined, runs on industry standard hardware and is 100% open source under the Apache V2 license.

This helm chart deploys a MinIO instance using a persistent NFS storage share off of the NetApp.

## Development

This chart was tailored for ease of deployment as an OLCF Slate service catalog offering from the original helm chart released by MinIO: [minio/charts](https://github.com/minio/charts) v8.0.10.

## Deployment

### Developer Catalog Method

Deployment from the Slate web console is accomplished via the Developer Perspective by using the option to add a Helm Chart from the Developer Catalog. Configuration of the MinIO instance may be accomplished via the Form View (normal method) or Yaml View (advanced options).

Once deployed, HelmRelease (HR) `Release Notes` are available via the Developer Perspective Topology view listing some access methods along with how to retrieve the MinIO application access and secret keys.

### Command Line Method

Deployment using helm commands works as well. After downloading and extracting the release from the Slate Helm Charts GitHub repository:

```bash
helm install --dry-run --debug ./minio-nfs --generate-name
helm install --names-space my-namespace --generate-name ./minio-nfs
helm ls
oc get secret minio-nfs-release -o jsonpath="{.data.accesskey}" | base64 --decode 
oc get secret minio-nfs-release -o jsonpath="{.data.secretkey}" | base64 --decode
helm uninstall minio-nfs-release
```

where `minio-nfs-release` is the helm generated name during the installation process.

## Configuration

The following lists all the configurable parameters exposed via the `values.yaml` file. Most of these are not configurable using the Developer Web Form deployment method. They are provided here for reference should some advanced application options be required for a specific use case.

| Parameter | Description | Default |
| --------- | ----------- | --------|
| `nameOverride` | Provide a name in place of minio | `""` |
| `fullnameOverride` | Provide a name to substitute for the full names of resources | `""` |
| `image.tag` | Image release tag | "RELEASE.2021-03-01T04-20-55Z" |
| `additionalLabels` | Additional labels for the deployment | `[]` |
| `additionalAnnotations` | Additional annotations for the deployment | `{}` |
| `podAnnotations` | Additional pod annotations | `{}` |
| `podLabels` | Additional pod labels | `{}` |
| `extraArgs` | Additional command line arguments to pass to the MinIO server | `[]` |
| `accessKey` | MinIO application access key (5 to 20 characters) | random 20 alphanumeric characters |
| `secretKey` | MinIO application secret key (8 to 40 characters) | random 40 alphanumeric characters |
| `mountPath` | Mount location for the persistent storage | `/export` |
| `existingSecret` | Name of an already existing secret with access and secret keys specified. | `""` |
| `bucketRoot` | Directory from where MinIO should manage buckets | `""` |
| `persistence.size` | The amount of storage allocated to the volume. | `50Gi` |
| `persistence.existingClaim` | Name of an already created PVC to use for the deployment | `""` |
| `persistence.subPath` | Name of a subfolder in the volume to use instead of volume root | `""` |
| `service.type` | Service type (ClusterIP, NodePort, LoadBalancer) | `ClusterIP` |
| `service.port` | Service port number exposed | `9000` |
| `service.externalIPs` | Service external IP addresses | `[]]` |
| `service.annotations` | Service annotations | `{}` |
| `route.enabled` | Whether or not the route creation should be enabled | `true` |
| `route.hostname` | Specific hostname to use for the route | `""` |
| `resources` | Default resource limits and requests | `{}` |
| `nodeSelector` | Node labels for pod assignment | `{}` |
| `tolerations` | Toleration labels for pod assignment | `[]` |
| `affinity` | Affinity settings for pod assignment | `{}` |
| `nasgateway.replicas` | Number of NAS gateway instances to be run in parallel | `4` |
| `nasgateway.pv` | Already existing PV to use for the backend storage | `~` |
| `environment` | Set MinIO server relevant environment variables. MinIO containers will be passed these variables when they start. | `{}` |
| `serviceAccount.enabled` | Whether or not a service account should be created | `true` |
| `serviceAccount.name` | Name of service account to create and/or use | "" |
| `networkPolicy.enabled` | Whether or not to create a network policy | `false` |
| `networkPolicy.allowExternal` | Whether or not to allow external cluster access | `true` |
