.python: clean
clean:
	rm -f "jaffle_shop.db"

unit-tests: setup-dbt
	bash ./run_unit_tests.sh

integration-tests: setup-dbt init-test-db dbt-build

setup-dbt:
	dbt deps

init-test-db: clean
	# Create a new test database
	python resources/duckdb/initialize_duckdb_database.py \
		--output jaffle_shop.db \
		--data resources/duckdb/data/

dbt-build:
	dbt --debug build

dbt-docs-generate:
	dbt docs generate
	dbt docs serve --port 18081
