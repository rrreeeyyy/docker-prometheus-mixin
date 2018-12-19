ARG PROMTOOL_VERSION=v2.5.0
ARG AMTOOL_VERSION=v0.15.3

FROM prom/prometheus:"$PROMTOOL_VERSION" as prometheus
FROM prom/alertmanager:"$AMTOOL_VERSION" as alertmanager

FROM alpine:3.8

COPY --from=prometheus /bin/promtool /bin/promtool
COPY --from=alertmanager /bin/amtool /bin/amtool

RUN apk add --no-cache --update make ca-certificates git build-base

WORKDIR /src

RUN git clone https://github.com/google/jsonnet.git
RUN cd jsonnet && make jsonnet
RUN cp -a jsonnet/jsonnet /bin/jsonnet
