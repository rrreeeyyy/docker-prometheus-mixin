{
  prometheusTests+:: {
    rule_files: [
      'out/prometheus_alerts.yml',
      'out/prometheus_rules.yml',
    ],
    evaluation_interval: '15s',
  },
}
