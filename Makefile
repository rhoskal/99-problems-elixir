# Build configuration
# -------------------

APP_NAME := `grep -Eo 'app: :\w*' mix.exs | cut -d ':' -f 3`
GIT_BRANCH :=`git rev-parse --abbrev-ref HEAD`
GIT_REVISION := `git rev-parse HEAD`

# Introspection targets
# ---------------------

.PHONY: help
help: header targets

.PHONY: header
header:
	@printf "\n\033[34mEnvironment\033[0m\n"
	@printf "\033[34m---------------------------------------------------------------\033[0m\n"
	@printf "\033[33m%-23s\033[0m" "APP_NAME"
	@printf "\033[35m%s\033[0m" $(APP_NAME)
	@echo ""
	@printf "\033[33m%-23s\033[0m" "GIT_BRANCH"
	@printf "\033[35m%s\033[0m" $(GIT_BRANCH)
	@echo ""
	@printf "\033[33m%-23s\033[0m" "GIT_REVISION"
	@printf "\033[35m%s\033[0m" $(GIT_REVISION)
	@echo ""

.PHONY: targets
targets:
	@printf "\n\033[34mTargets\033[0m\n"
	@printf "\033[34m---------------------------------------------------------------\033[0m\n"
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-22s\033[0m %s\n", $$1, $$2}'

# Development targets
# -------------------

.PHONY: clean
clean: ## Remove build artifacts
	rm -rf _build

.PHONY: deps
deps: ## Install deps
	mix deps.get --force

.PHONY: run
run: ## Run iex
	iex -S mix

.PHONY: test
test: ## Test code
	mix test

.PHONY: verify
verify: ## Run dialyzer to verify typespecs
	mix dialyzer

# Check, lint and format targets
# ------------------------------

.PHONY: format
format: ## Format files
	mix format

.PHONY: lint
lint: ## Lint files
	mix credo
