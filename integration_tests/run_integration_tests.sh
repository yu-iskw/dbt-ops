#!/bin/bash

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

set -Eeuo pipefail

# Constants
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
DUCKDB_FILE="${SCRIPT_DIR}/jaffle_shop.db"

# Create a new test database
rm -f "${DUCKDB_FILE}"
python resources/duckdb/initialize_duckdb_database.py \
    --output "${DUCKDB_FILE}" \
    --data resources/duckdb/data/

# Run dbt
dbt build

# Run macros
dbt run-operation find_unreferenced_sources
dbt run-operation find_downstream_nodes \
	--args '{"unique_id": "model.integration_tests.stg_orders", "resource_types": ["model", "snapshot", "exposure"]}'
dbt run-operation find_upstream_nodes \
	--args '{"unique_id": "model.integration_tests.orders", "resource_types": ["model", "snapshot", "source"]}'
