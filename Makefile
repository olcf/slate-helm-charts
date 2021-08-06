help:
	echo "make index"

index:
	helm repo index . --url https://olcf.github.io/slate-helm-charts/

package: lint
	helm package $(PKG) -d charts

lint:
	helm lint $(PKG)
