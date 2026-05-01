{{- define "player-fe.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "player-fe.commonLabels" -}}
helm.sh/chart: {{ include "player-fe.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of: player-fe
{{- end }}

{{- define "player-fe.playerFe.labels" -}}
app: player-fe
{{ include "player-fe.commonLabels" . }}
{{- end }}
