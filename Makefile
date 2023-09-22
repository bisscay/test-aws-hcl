main: plan

validate:
	@terraform validate

fmt: validate
	@terraform fmt

plan: fmt
	terraform plan