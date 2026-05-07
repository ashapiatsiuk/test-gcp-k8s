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

{{/* When app Secret Manager mount is disabled, TLS CSI sync uses ingress.tls.secretProviderClassName. */}}
{{- define "player-fe.secretProviderClassName" -}}
{{- if .Values.playerFe.secretManager.enabled -}}
{{- .Values.playerFe.secretManager.secretProviderClassName -}}
{{- else -}}
{{- default "player-fe-csi" .Values.ingress.tls.secretProviderClassName -}}
{{- end -}}
{{- end }}

{{- define "player-fe.csiTlsEnabled" -}}
{{- and .Values.ingress.tls.csiSync .Values.ingress.tlsSecretName -}}
{{- end }}

{{- define "player-fe.csiVolumeNeeded" -}}
{{- or .Values.playerFe.secretManager.enabled (include "player-fe.csiTlsEnabled" .) -}}
{{- end }}
