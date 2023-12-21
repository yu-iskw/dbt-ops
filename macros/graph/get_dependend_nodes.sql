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

{#
  Recursively get nodes that the given node depends on
#}

{% macro get_node_depends_on(unique_id) %}
  {% set focused_node = dbt_ops.get_node_by_unique_id(unique_id) %}

  {% if not focused_node %}
    {{ exceptions.raise_compiler_error("Node not found by unique_id: " + unique_id) }}
  {% endif %}

  {% set returned_value = {focused_node.unique_id: {"depends_on": {}}} %}

  {% if focused_node.depends_on and focused_node.depends_on.nodes %}
    {% for dependent_unique_id in focused_node.depends_on.nodes %}
      {% set dependent_node = dbt_ops.get_node_depends_on(dependent_unique_id) %}

      {% do returned_value[unique_id]["depends_on"].update({dependent_unique_id: dependent_node}) %}
    {% endfor %}
  {% endif %}

  {{ return(returned_value) }}
{% endmacro %}
