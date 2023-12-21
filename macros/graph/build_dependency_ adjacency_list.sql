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

{% macro build_dependenncy_adjacency_list() %}
  {#
    Build the adjacency list from the graph of dependency.
  #}

  {% set adjacency_list = {} %}

  {% for node in graph.nodes.values() %}
    {% set source_unique_id = node.unique_id %}

    {% if node.depends_on and node.depends_on.nodes %}
      {% do adjacency_list.update({source_unique_id: node.depends_on.nodes})%}
    {% endif %}
  {% endfor %}

  {{ return(adjacency_list) }}
{% endmacro %}

{% macro transpose_adjacency_list(adjacency_list) %}
  {% set transposed_adjacency_list = {} %}

  {% for source_unique_id, destination_unique_ids in adjacency_list.items() %}
    {% for destination_unique_id in destination_unique_ids %}
      {% if destination_unique_id not in transposed_adjacency_list %}
        {% do transposed_adjacency_list.update({destination_unique_id: []}) %}
      {% endif %}

      {% do transposed_adjacency_list[destination_unique_id].append(source_unique_id) %}
    {% endfor %}
  {% endfor %}

  {{ return(transposed_adjacency_list) }}
{% endmacro %}
