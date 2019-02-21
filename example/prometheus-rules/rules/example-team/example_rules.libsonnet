{
  prometheusRules+:: {
    groups+: [
      {
        name: 'example.rules',
        rules: [
          {
            // Recording rules should be the general form `level:metric:operations`.
            // refs: https://prometheus.io/docs/practices/rules/
            record: 'instance:node_cpu_count_prometheus:sum',
            expr: |||
              count by (instance) (
                sum by (instance, cpu) (
                  node_cpu{role="prometheus"}
                )
              )
            ||| % $._config,
          },
        ],
      },
    ],
  },
}
