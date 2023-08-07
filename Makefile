hello:
	echo "Hello World!"
	echo "this command will run after first line"

targets: prerequisites
	command
	command
	command

help: ## Help documentation
	@ echo ""
	@ echo "+------------------------------------+"
	@ echo "|       AWS HELP         |"
	@ echo "+------------------------------------+"
	@ echo ""
	@ echo "Available targets:"
	@ echo ""
	@ grep --no-filename -E '^[-a-zA-Z_:]+.*[^#]## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' | \
		sort
	@ echo ""

.DEFAULT_GOAL := help