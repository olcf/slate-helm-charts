{{/*
Expand the name of the chart.
*/}}
{{- define "mongo-40.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mongo-40.fullname" -}}
{{- $name := default .Release.Name .Values.nameOverride -}}
{{- printf "%s" $name | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mongo-40.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mongo-40.labels" -}}
helm.sh/chart: {{ include "mongo-40.chart" . }}
{{ include "mongo-40.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mongo-40.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mongo-40.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Restic Backup Password
*/}}
{{- define "restic.password" -}}
{{- $mysecret := printf "%s-stash-secret" (include "mongo-40.fullname" .) }}
{{- $secret := (lookup "v1" "Secret" .Release.Namespace $mysecret) }}
{{- if $secret -}}
{{-  index $secret.data "RESTIC_PASSWORD" -}}
{{- else -}}
{{ if .Values.stash.restic_password }}{{ .Values.stash.restic_password | toString | b64enc | quote }}{{ else }}{{ randAlphaNum 20 | b64enc | quote }}{{ end }}
{{- end -}}
{{- end -}}

