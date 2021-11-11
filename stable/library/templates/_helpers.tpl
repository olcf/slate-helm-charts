{{- define "library.runAsUsername" -}}
{{- $ns := lookup "v1" "Namespace" "" .Release.Namespace }}
{{- if $ns }}
  {{- $value := index $ns.metadata.annotations "ccs.ornl.gov/runAsUsername" }}
  {{- if $value }}
    {{- printf "%s" $value }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "library.runAsUser" -}}
{{- $ns := lookup "v1" "Namespace" "" .Release.Namespace }}
{{- if $ns }}
  {{- $value := index $ns.metadata.annotations "ccs.ornl.gov/runAsUser" }}
  {{- if $value }}
    {{- printf "%s" $value }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "library.runAsGroup" -}}
{{- $ns := lookup "v1" "Namespace" "" .Release.Namespace }}
{{- if $ns }}
  {{- $value := index $ns.metadata.annotations "ccs.ornl.gov/runAsGroup" }}
  {{- if $value }}
    {{- printf "%s" $value }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "library.project" -}}
{{- $ns := lookup "v1" "Namespace" "" .Release.Namespace }}
{{- if $ns }}
  {{- $value := index $ns.metadata.labels "ccs.ornl.gov/project" }}
  {{- if $value }}
    {{- printf "%s" $value }}
  {{- end }}
{{- end }}
{{- end }}