{
  alertmanagerConfig+:: {
    route: {
      receiver: 'sre-slack',
      group_by: ['alertname'],
      group_wait: '30s',
      group_interval: '5m',
      repeat_interval: '3h',
    },
  },
}
