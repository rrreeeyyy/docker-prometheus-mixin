{
  alertmanagerConfig+:: {
    route+: {
      routes+: [{
        match: { pager: 'sre' },
        receiver: 'sre-slack',
        routes: [{
          match: { severity: 'critical' },
          receiver: 'sre-pagerduty',
        }],
      }],
    },
  },
}
