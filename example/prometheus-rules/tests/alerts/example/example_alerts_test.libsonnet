{
  prometheusTests+:: {
    tests+: [{
      interval: '15s',
      input_series: [
        { series: 'up{job="prometheus", instance="prometheus-001"}', values: '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0' },
      ],
      alert_rule_test: [{
        eval_time: '1m',
        alertname: 'ExampleWarningAlertPrometheusDownFor1min',
        exp_alerts: [
          {
            exp_labels: {
              pager: 'sre',
              severity: 'critical',
              job: 'prometheus',
              instance: 'prometheus-001',
            },
            exp_annotations: {
              title: 'prometheus is unreachable',
              description: 'prometheus at prometheus-001 could not be scraped for over 1 minutes.',
            },
          },
        ],
      }],
    }],
  },
}
