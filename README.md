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

First we will create the tgz package of the chart

```bash
make package PKG=stable/chart
```

Update repository index

```bash
make index
```

```bash
git add charts index.yaml
```

Once the changes are committed to master and pushed to GitHub, they will be available for use.
