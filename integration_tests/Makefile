clean: clean-dbt clean-integration-tests

clean-dbt:
	dbt clean

setup-dbt:
	dbt deps

dbt-build:
	dbt --debug build

dbt-docs-generate:
	dbt docs generate
	dbt docs serve --port 18081

unit-tests: setup-dbt
	bash ./run_unit_tests.sh

clean-integration-tests:
	rm -f "jaffle_shop.db"

create-test-database:
	python resources/duckdb/initialize_duckdb_database.py \
		--output "jaffle_shop.db" \
		--data resources/duckdb/data/

integration-tests: clean setup-dbt create-test-database dbt-build
	bash ./run_macros.sh
