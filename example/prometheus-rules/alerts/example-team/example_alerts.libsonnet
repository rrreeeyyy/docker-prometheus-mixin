{
  prometheusAlerts+:: {
    groups+: [
      {
        name: 'example-alerts',
        rules: [
          {
            alert: 'ExampleWarningAlertPrometheusDownFor1min',
            expr: |||
              up{%(prometheusSelector)s} == 0
            ||| % $._config,
            'for': '1m',
            labels: {
              pager: 'sre',
              severity: 'critical',
            },
            annotations: {
              title: '{{$labels.job}} is unreachable',
              description: '{{$labels.job}} at {{$labels.instance}} could not be scraped for over 1 minutes.',
            },
          },
        ],
      },
    ],
  },
}
