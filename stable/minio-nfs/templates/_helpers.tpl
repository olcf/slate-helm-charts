{{/*
Expand the name of the chart.
*/}}
{{- define "minio-nfs.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "minio-nfs.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "minio-nfs.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "minio-nfs.labels" -}}
helm.sh/chart: {{ include "minio-nfs.chart" . }}
{{ include "minio-nfs.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "minio-nfs.selectorLabels" -}}
app.kubernetes.io/name: {{ include "minio-nfs.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Return the appropriate apiVersion for networkpolicy.
*/}}
{{- define "minio-nfs.networkPolicy.apiVersion" -}}
{{- if semverCompare ">=1.4-0, <1.7-0" .Capabilities.KubeVersion.Version -}}
{{- print "extensions/v1beta1" -}}
{{- else if semverCompare "^1.7-0" .Capabilities.KubeVersion.Version -}}
{{- print "networking.k8s.io/v1beta1" -}}
{{- end -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for deployment.
*/}}
{{- define "minio-nfs.deployment.apiVersion" -}}
{{- if semverCompare "<1.9-0" .Capabilities.KubeVersion.Version -}}
{{- print "apps/v1beta2" -}}
{{- else -}}
{{- print "apps/v1" -}}
{{- end -}}
{{- end -}}

{{/*
Determine secret name.
*/}}
{{- define "minio-nfs.secretName" -}}
{{- if .Values.existingSecret -}}
{{- .Values.existingSecret }}
{{- else -}}
{{- include "minio-nfs.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Determine service account name for deployment or statefulset.
*/}}
{{- define "minio-nfs.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default (include "minio-nfs.fullname" .) .Values.serviceAccount.name | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- default "default" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}
{{/*

Properly format optional additional arguments to Minio binary
*/}}
{{- define "minio-nfs.extraArgs" -}}
{{- range .Values.extraArgs -}}
{{ " " }}{{ . }}
{{- end -}}
{{- end -}}
