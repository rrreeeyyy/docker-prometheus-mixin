{
  alertmanagerConfig+:: {
    inhibit_rules+: [{
      source_match: { severity: 'critical' },
      target_match: { severity: 'warning' },
      equal: ['alertname'],
    }],
  },
}
