# Copyright 2023 yu-iskw
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import os
import argparse
import loguru
import textwrap
import duckdb

logger = loguru.logger

def create_and_load_customers_table(connection: duckdb.DuckDBPyConnection, input_file: str):
    """Create and load the customers table."""
    logger.info(f"Creating and loading the raw_customers table from {input_file}.")
    connection.sql(f"CREATE OR REPLACE TABLE raw_customers AS SELECT * FROM read_csv_auto('{input_file}')")
    connection.sql("DESCRIBE raw_customers").show()
    connection.sql("SELECT COUNT(*) FROM raw_customers").show()
    # The table is used to test getting unrefereced table(s).
    logger.info(f"Creating and loading the old_raw_customers table from {input_file}.")
    connection.sql(f"CREATE OR REPLACE TABLE old_raw_customers AS SELECT * FROM read_csv_auto('{input_file}')")

def create_and_load_orders_table(connection: duckdb.DuckDBPyConnection, input_file: str):
    """Create and load the orders table."""
    logger.info(f"Creating and loading the raw_orders table from {input_file}.")
    connection.sql(f"CREATE OR REPLACE TABLE raw_orders AS SELECT * FROM read_csv_auto('{input_file}')")
    connection.sql("DESCRIBE raw_orders").show()
    connection.sql("SELECT COUNT(*) FROM raw_orders").show()

def create_and_load_payments_table(connection: duckdb.DuckDBPyConnection, input_file: str):
    """Create and load the payments table."""
    logger.info(f"Creating and loading the raw_payments table from {input_file}.")
    connection.sql(f"CREATE OR REPLACE TABLE raw_payments AS SELECT * FROM read_csv_auto('{input_file}')")
    connection.sql("DESCRIBE raw_payments").show()
    connection.sql("SELECT COUNT(*) FROM raw_payments").show()

def show_databases_and_tables(connection: duckdb.DuckDBPyConnection):
    """Show the databases and tables."""
    logger.info("Showing the databases:")
    connection.sql("SHOW DATABASES").show()
    logger.info("Showing the tables:")
    connection.sql("SHOW TABLES").show()

# main function
def main(data_dir: str, output_file: str):
    connection = duckdb.connect(database=output_file, read_only=False)
    customers_csv = os.path.join(data_dir, 'customers.csv')
    create_and_load_customers_table(connection=connection, input_file=f'{data_dir}/raw_customers.csv')
    create_and_load_orders_table(connection=connection, input_file=f'{data_dir}/raw_orders.csv')
    create_and_load_payments_table(connection=connection, input_file=f'{data_dir}/raw_payments.csv')
    show_databases_and_tables(connection=connection)
    connection.close()

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Initialize DuckDB database.')
    parser.add_argument('--data', help='the path to the data directory')
    parser.add_argument('--output', help='the path to the output file')
    args = parser.parse_args()
    data = args.data
    output = args.output
    main(data_dir=data, output_file=output)
