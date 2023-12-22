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

{% macro test_transpose_adjacency_list() %}
  {% set adjacency_list = dbt_ops.build_dependenncy_adjacency_list() %}
  {% set transposed_adjacency_list = dbt_ops.transpose_adjacency_list(adjacency_list) %}

  {% do assert_equals(transposed_adjacency_list | length, 9) %}

  {% set expected_keys = [
    'model.integration_tests.stg_customers',
    'model.integration_tests.stg_orders',
    'model.integration_tests.stg_payments',
    'source.integration_tests.main.raw_customers',
    'source.integration_tests.main.raw_payments',
    'source.integration_tests.main.raw_orders',
    'model.integration_tests.customers',
    'source.integration_tests.main.old_raw_customers',
    'model.integration_tests.orders'
    ] %}

  {% for expected_key in expected_keys %}
    {% if expected_key not in transposed_adjacency_list %}
      {{ exceptions.raise_compiler_error("The key '" ~ expected_key ~ "' is not found in the transposed adjacency list.") }}
    {% endif %}
  {% endfor %}
{% endmacro %}
