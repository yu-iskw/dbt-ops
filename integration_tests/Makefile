setup-dbt:
	dbt deps

dbt-build:
	dbt --debug build

dbt-docs-generate:
	dbt docs generate
	dbt docs serve --port 18081

unit-tests: setup-dbt
	bash ./run_unit_tests.sh

integration-tests:
	bash ./run_integration_tests.sh
