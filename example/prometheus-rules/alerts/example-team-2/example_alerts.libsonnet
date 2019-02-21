{
  prometheusAlerts+:: {
    groups+: [
      {
        name: 'example-alerts-2',
        rules: [
          {
            alert: 'ExampleWarningAlertNodeExporterDownFor1min',
            expr: |||
              up{%(nodeExporterSelector)s} == 0
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
