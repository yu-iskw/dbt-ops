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

{% macro test_build_dependenncy_adjacency_list() %}
  {% set adjacency_list = dbt_ops.build_dependenncy_adjacency_list() %}
  {% do assert_equals(adjacency_list | length, 38) %}

  {% set models_and_sources = [
    'model.integration_tests.customers',
    'model.integration_tests.orders',
    'model.integration_tests.stg_customers',
    'model.integration_tests.stg_orders',
    'model.integration_tests.stg_payments',
  ] %}

  {% for unique_id in models_and_sources %}
    {% if unique_id not in adjacency_list %}
      {{ exceptions.raise_compiler_error("The unique_id '" ~ unique_id ~ "' is not found in the adjacency list.") }}
    {% endif %}
  {% endfor %}

  {% set customers_depends_on = adjacency_list["model.integration_tests.orders"] %}
  {% for unique_id in ['model.integration_tests.stg_orders', 'model.integration_tests.stg_payments'] %}
    {% if unique_id not in customers_depends_on %}
      {{ exceptions.raise_compiler_error("The unique_id '" ~ unique_id ~ "' is not found in the adjacency list.") }}
    {% endif %}
  {% endfor %}


{% endmacro %}
