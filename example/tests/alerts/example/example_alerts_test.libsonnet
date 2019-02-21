{
  prometheusTests+:: {
    tests+: [{
      interval: '15s',
      input_series: [
        { series: 'up{job="prometheus"}', values: '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0' },
      ],
      alert_rule_test: [{
        eval_time: '10m',
        alertname: 'ExampleWarningAlertPrometheusDownFor1min',
        exp_alerts: [
          {
            exp_labels: {
              pager: 'sre',
              severity: 'critical',
              job: 'prometheus',
            },
            exp_annotations: {
              title: 'prometheus is unreachable',
              description: 'prometheus at could not be scraped for over 10 minutes.',
            },
          },
        ],
      }],
    }],
  },
}
