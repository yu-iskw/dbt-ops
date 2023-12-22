{#
  Copyright 2023 yu-iskw

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
#}

{% macro test_get_node_by_unique_id() %}
  {% set unique_ids = [
    'source.integration_tests.main.raw_customers',
    'source.integration_tests.main.raw_payments',
    'source.integration_tests.main.raw_orders',
    'source.integration_tests.main.old_raw_customers',
    'model.integration_tests.stg_customers',
    'model.integration_tests.stg_orders',
    'model.integration_tests.stg_payments',
    'model.integration_tests.customers',
    'model.integration_tests.orders'
  ] %}
  {% for unique_id in unique_ids %}
    {% set node = dbt_ops.get_node_by_unique_id(unique_id) %}
    {% if node is none %}
      {{ exceptions.raise_compiler_error("The node '" ~ unique_id ~ "' is not found.") }}
    {% endif %}
  {% endfor %}
{% endmacro %}
