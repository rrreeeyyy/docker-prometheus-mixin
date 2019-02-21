PROJECT_ROOT := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
JSONNET_FMT := jsonnet fmt
OUT_DIR := out

.PHONY: $(OUT_DIR) all clean fmt lint $(OUT_DIR)/alertmanager.yml

all: fmt routes.libsonnet receivers.libsonnet $(OUT_DIR) $(OUT_DIR)/alertmanager.yml

fmt:
	find . -name 'vendor' -prune -o -name '*.libsonnet' -print -o -name '*.jsonnet' -print | \
		xargs -n 1 -- $(JSONNET_FMT) -i

$(OUT_DIR):
	mkdir -p $(OUT_DIR)

$(OUT_DIR)/alertmanager.yml: mixin.libsonnet lib/*.jsonnet receivers/**/*.libsonnet routes/*.libsonnet | $(OUT_DIR)
	jsonnet -S lib/alertmanager.jsonnet > $@

routes.libsonnet: routes/*.libsonnet
	jsonnet -S lib/generate_multiple_import.jsonnet --ext-str importFiles="$^" > routes.libsonnet

receivers.libsonnet: receivers/**/*.libsonnet
	jsonnet -S lib/generate_multiple_import.jsonnet --ext-str importFiles="$^" > receivers.libsonnet

lint: receivers.libsonnet routes.libsonnet $(OUT_DIR)/alertmanager.yml
	find . -name 'vendor' -prune -o -name '*.libsonnet' -print -o -name '*.jsonnet' -print | \
		while read f; do $(JSONNET_FMT) "$$f" | diff -u "$$f" -; \
			if [ $$? -eq 1 ]; then \
				echo "ERROR: $$f isn't formatted. Please format by \`make fmt\`." >&2 ; \
				exit 1; \
			fi \
		done

	amtool check-config $(OUT_DIR)/alertmanager.yml

clean:
	rm -rf $(OUT_DIR)
