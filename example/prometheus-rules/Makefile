PROMETHEUS_VERSION := v2.5.0
PROJECT_ROOT := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
JSONNET_FMT := jsonnet fmt
OUT_DIR := out

.PHONY: $(OUT_DIR) all clean fmt lint alerts.libsonnet rules.libsonnet tests.libsonnet $(OUT_DIR)/prometheus_alerts.yml $(OUT_DIR)/prometheus_rules.yml prometheus_tests.yml

all: alerts.libsonnet rules.libsonnet fmt $(OUT_DIR) $(OUT_DIR)/prometheus_alerts.yml $(OUT_DIR)/prometheus_rules.yml prometheus_tests.yml lint

fmt:
	find . -name 'vendor' -prune -o -name '*.libsonnet' -print -o -name '*.jsonnet' -print | \
		xargs -n 1 -- $(JSONNET_FMT) -i

$(OUT_DIR):
	mkdir -p $(OUT_DIR)

$(OUT_DIR)/prometheus_alerts.yml: mixin.libsonnet lib/alerts.jsonnet alerts/**/*.libsonnet tests.libsonnet| $(OUT_DIR)
	jsonnet -S lib/alerts.jsonnet > $@

$(OUT_DIR)/prometheus_rules.yml: mixin.libsonnet lib/rules.jsonnet rules/**/*.libsonnet tests.libsonnet| $(OUT_DIR)
	jsonnet -S lib/rules.jsonnet > $@

prometheus_tests.yml: mixin.libsonnet tests.libsonnet lib/alerts.jsonnet lib/rules.jsonnet
	jsonnet -S lib/tests.jsonnet > $@

alerts.libsonnet: alerts/**/*.libsonnet
	jsonnet -S lib/generate_multiple_import.jsonnet --ext-str importFiles="$^" > alerts.libsonnet

rules.libsonnet: rules/**/*.libsonnet
	jsonnet -S lib/generate_multiple_import.jsonnet --ext-str importFiles="$^" > rules.libsonnet

tests.libsonnet: tests/**/**/*.libsonnet
	jsonnet -S lib/generate_multiple_import.jsonnet --ext-str importFiles="$^" > tests.libsonnet

lint: alerts.libsonnet rules.libsonnet tests.libsonnet $(OUT_DIR)/prometheus_alerts.yml $(OUT_DIR)/prometheus_rules.yml prometheus_tests.yml
	find . -name 'vendor' -prune -o -name '*.libsonnet' -print -o -name '*.jsonnet' -print | \
		while read f; do $(JSONNET_FMT) "$$f" | diff -u "$$f" -; \
			if [ $$? -eq 1 ]; then \
				echo "ERROR: $$f isn't formatted. Please format by \`make fmt\`." >&2 ; \
				exit 1; \
			fi \
		done

	promtool check rules $(OUT_DIR)/prometheus_rules.yml
	promtool check rules $(OUT_DIR)/prometheus_alerts.yml

	promtool test rules prometheus_tests.yml

	@echo "Generated prometheus_rules.yml:"
	cat $(OUT_DIR)/prometheus_rules.yml

	@echo "Generated prometheus_alerts.yml:"
	cat $(OUT_DIR)/prometheus_alerts.yml

clean:
	rm -rf $(OUT_DIR)
