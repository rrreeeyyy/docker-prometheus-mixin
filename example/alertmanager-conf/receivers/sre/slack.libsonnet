{
  alertmanagerConfig+:: {
    receivers+: [
      {
        name: 'sre-slack',
        slack_configs: [
          {
            send_resolved: true,
            channel: '#sre',
          },
        ],
      },
    ],
  },
}
