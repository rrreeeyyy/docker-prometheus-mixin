# docker-prometheus-mixin

## Usage

```
docker pull rrreeeyyy/docker-prometheus-mixin
```

```
docker run --rm rrreeeyyy/docker-prometheus-mixin jsonnet -v
docker run --rm rrreeeyyy/docker-prometheus-mixin promtool --version
docker run --rm rrreeeyyy/docker-prometheus-mixin amtool --version
```

## Examples

### prometheus-rules

Check format to all jsonnet/libsonnet and `promtool {check,test} rules` to generated `prometheus_{rules,alerts,tests}.yml`

```
docker run -it --rm -v "$(pwd)/example/prometheus-rules:/src/prometheus-rules" -w /src/prometheus-rules rrreeeyyy/docker-prometheus-mixin make lint
```

Generate `prometheus_{rules,alerts}.yml` from jsonnet/libsonnet

```
docker run -it --rm -v "$(pwd)/example/prometheus-rules:/src/prometheus-rules" -w /src/prometheus-rules rrreeeyyy/docker-prometheus-mixin make
```

Check generated `prometheus_{rules,alerts}.yml`

```
cat $(pwd)/example/prometheus-rules/out/prometheus_{rules,alerts}.yml
```

### alertmanager-conf

Check format to all jsonnet/libsonnet and `amtool check-config` to generated `alertmanager.yml`

```
docker run -it --rm -v "$(pwd)/example/alertmanager-conf:/src/alertmanager-conf" -w /src/alertmanager-conf rrreeeyyy/docker-prometheus-mixin make lint
```

Generate `alertmanager.yml` from jsonnet/libsonnet

```
docker run -it --rm -v "$(pwd)/example/alertmanager-conf:/src/alertmanager-conf" -w /src/alertmanager-conf rrreeeyyy/docker-prometheus-mixin make lint
```

Check generated `alertmanager.yml`

```
cat $(pwd)/example/alertmanager-conf/out/alertmanager.yml
```
