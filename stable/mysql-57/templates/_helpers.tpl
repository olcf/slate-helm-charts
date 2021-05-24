{{/*
Expand the name of the chart.
*/}}
{{- define "mysql-57.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mysql-57.fullname" -}}
{{- $name := default .Release.Name .Values.nameOverride -}}
{{- printf "%s" $name | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mysql-57.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mysql-57.labels" -}}
helm.sh/chart: {{ include "mysql-57.chart" . }}
{{ include "mysql-57.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mysql-57.selectorLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Restic Backup Password
*/}}
{{- define "restic.password" -}}
{{- $mysecret := printf "%s-stash-secret" (include "mysql-57.fullname" .) }}
{{- $secret := (lookup "v1" "Secret" .Release.Namespace $mysecret) }}
{{- if $secret -}}
{{-  index $secret.data "RESTIC_PASSWORD" -}}
{{- else -}}
{{ if .Values.stash.restic_password }}{{ .Values.stash.restic_password | toString | b64enc | quote }}{{ else }}{{ randAlphaNum 20 | b64enc | quote }}{{ end }}
{{- end -}}
{{- end -}}
