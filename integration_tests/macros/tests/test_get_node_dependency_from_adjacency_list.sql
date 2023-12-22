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

{% macro test_get_node_dependency_from_adjacency_list() %}
  {% set adjacency_list = dbt_ops.build_dependenncy_adjacency_list() %}
  {% set node_dependency_info = dbt_ops.get_node_dependency_from_adjacency_list(
      adjacency_list, "model.integration_tests.stg_customers") %}

  {% set depends_on = node_dependency_info["model.integration_tests.stg_customers"]["depends_on"].keys() %}
  {% if depends_on | length != 1 %}
    {{ exceptions.raise_compiler_error("The length of depends_on is not 1. But, " + depends_on | length) }}
  {% endif %}
  {% if "source.integration_tests.main.raw_customers" not in depends_on  %}
    {{ exceptions.raise_compiler_error("The key 'source.integration_tests.main.raw_customers' is not found in depends_on.") }}
  {% endif %}
{% endmacro %}
