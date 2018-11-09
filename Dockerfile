ARG PROMTOOL_VERSION=v2.2.1

FROM prom/prometheus:"$PROMTOOL_VERSION" as prometheus

FROM alpine:3.8

COPY --from=prometheus /bin/promtool /bin/promtool

RUN apk add --no-cache --update make ca-certificates git build-base

WORKDIR /src

RUN git clone https://github.com/google/jsonnet.git
RUN cd jsonnet && make jsonnet
RUN cp -a jsonnet/jsonnet /bin/jsonnet
