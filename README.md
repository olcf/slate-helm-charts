# Slate Helm Charts

This repository holds the helm charts that appear in Slate's service catalog for users to easily deploy into their project namespace

## Chart Addition Process

Once a chart has been developed, helm can be used to create a versioned chart archive file (.tgz) with a process similar to:

```bash
minio-nfs $ helm lint
==> Linting .

1 chart(s) linted, 0 chart(s) failed

minio-nfs $ cd ../

dev $ helm package ./minio-nfs
Successfully packaged chart and saved it to: ~/dev/minio-nfs-1.0.0.tgz
```

Copy the chart archive to the `charts` directory of this repoisitory, and then regenerate the `index.yaml` file:

```bash
slate-helm-charts $ cp ~/dev/minio-nfs-1.0.0.tgz charts/
slate-helm-charts $ cd ../
slate-helm-charts $ helm repo index slate-helm-charts/ --url https://olcf.github.io/slate-helm-charts/
```

Once the changes are commited to master and pushed to GitHub, they will be available for use.

