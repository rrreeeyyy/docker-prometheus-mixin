{
  alertmanagerConfig+:: {
    receivers+: [
      {
        name: 'sre-pagerduty',
        pagerduty_configs: [
          { service_key: '{{ template "secrets.pagerduty.sre.service_key" }}' },
        ],
      },
    ],
  },
}
