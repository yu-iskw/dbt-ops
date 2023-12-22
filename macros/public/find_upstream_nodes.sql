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

{% macro find_upstream_nodes(
    unique_id,
    resource_types=['model', 'semantic_model', 'source', 'seed', 'snapshot', 'metric', 'test', 'exposure', 'analysis']) %}
  {% if not unique_id %}
    {{ exceptions.raise_compiler_error("unique_id is required.") }}
  {% endif %}

  {% set adjacency_list = dbt_ops.build_dependenncy_adjacency_list() %}
  {% set dependency_node_info = dbt_ops.get_node_dependency_from_adjacency_list(adjacency_list, unique_id) %}

  {{ print_node_dependency(dependency_node_info, resource_types=resource_types) }}
{% endmacro %}
