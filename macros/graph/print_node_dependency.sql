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

{% macro print_node_dependency(
    dependency_node_info,
    depth=0,
    parent_item=none,
    indent_spaces=2,
    resource_types=['model', 'semantic_model', 'source', 'seed', 'snapshot', 'metric', 'test', 'exposure', 'analysis']) %}
  {#
    print node dependency in the following format:

    ```
    └── 1: model.xxxx.xxx (view)
       ├── 1.1: model.yyy.yyy (incremental)
       │   └── 1.1.1: model.yyy.xxx (model)
       ├── 1.2: model.yyy.yyy (view)
       └── 1.3: model.yyy.yyy (view)
           └── 1.3.1: model.yyy.xxx (view)
               └── 1.3.1.1: model.yyy.xxx (table)
    ```
  #}

  {% for unique_id in dependency_node_info.keys() %}
    {% set node = dependency_node_info[unique_id]["node"] %}
    {% set depends_on = dependency_node_info[unique_id]["depends_on"] %}

    {% set current_list_item = none %}
    {% if parent_item %}
      {% set current_list_item = "%s.%s"|format(parent_item,loop.index) %}
    {% else %}
      {% set current_list_item = "%s"|format(loop.index) %}
    {% endif %}

    {% if node.resource_type in resource_types %}
      {% if node.config and node.config.materialized %}
       {{ print("- %s: %s (%s:%s)"
            | format( current_list_item, node.unique_id, node.resource_type, node.config.materialized)
            | indent(depth * indent_spaces, true) ) }}
      {% else %}
       {{ print("- %s: %s (%s)"
            | format( current_list_item, node.unique_id, node.resource_type)
            | indent(depth * indent_spaces, true) ) }}
      {% endif %}
    {% endif %}

    {{ dbt_ops.print_node_dependency(depends_on, depth + 1, current_list_item, indent_spaces, resource_types=resource_types) }}
  {% endfor %}
{% endmacro %}
