# Slate Helm Charts

This repository holds the helm charts that appear in Slate's service catalog for users to easily deploy into their project namespace

## Chart Development

Helm provides a command to create a directory structure for a new chart:

```bash
stable $ helm create minio-nfs
Creating minio-nfs
```

Once created, enter the chart code directory to modify, remove, and/or add template files for the desired installation. Create an appropriate values.yaml file as templates are developed. generate a values.schema.json file used to modify the offering form within OpenShift. An initial values.schema.json file may be generated with:

```bash
minio-nfs $ helm schema-gen values.yaml > values.schema.json
```

Additionally, the Chart.yaml file should be modified with appropriate information to include a SemVer version.

## Chart Release Process

Once a chart has been developed, it needs to be added to the repository.

Helm is used to create a versioned chart archive file (.tgz) with a process similar to:

```bash
minio-nfs $ helm lint
==> Linting .

1 chart(s) linted, 0 chart(s) failed

minio-nfs $ cd ../

~ $ helm package ./minio-nfs -d charts
Successfully packaged chart and saved it to: ~/charts/minio-nfs-1.0.0.tgz
```

Move the chart archive to the `charts` directory of this repository, and then regenerate the `index.yaml` file:

```bash
stable $ mv minio-nfs-1.0.0.tgz ../charts/
stable $ cd ../../
~ $ helm repo index . --url https://olcf.github.io/slate-helm-charts/
```

Once the changes are committed to master and pushed to GitHub, they will be available for use.
