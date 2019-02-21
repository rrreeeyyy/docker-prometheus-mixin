{
  alertmanagerConfig+:: {
    global+: {
      resolve_timeout: '5m',
      slack_api_url: 'https://hooks.slack.com/services/XXXXXXXXX/XXXXXXXXX/xxxxxxxxxxxxxxxxxxxxxxxx',
    },
  },
}
