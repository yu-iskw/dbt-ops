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

{% macro find_unreferenced_sources(format='text', reference_resource_types = ['model', 'snapshot', 'exposure']) %}
  {#
    The macro enables us to get unreferenced sources so that we can maintain dbt projects.
    It returns a list of sources that are not referenced by any models, snapshots, or exposures.
  #}
  {% set unreferenced_sources = __find_unreferenced_sources(reference_resource_types) %}

  {% if format == 'text' %}
    {% for unique_id in unreferenced_sources %}
      {{ print(unique_id) }}
    {% endfor %}
  {% elif format == 'json' %}
    {{ print(tojson(unreferenced_sources)) }}
  {% elif format == 'yaml' %}
    {{ print(toyaml(unreferenced_sources)) }}
  {% else %}
    {{ exceptions.raise_compiler_error("Invalid `format`. Got: " ~ format) }}
  {% endif %}
{% endmacro %}

{% macro __find_unreferenced_sources(reference_resource_types = ['model', 'snapshot', 'exposure']) %}
  {# Get all sources #}
  {% set all_sources = {} %}
  {% for source in graph.sources.values() %}
    {% do all_sources.update({source.unique_id: false}) %}
  {% endfor %}

  {# Get all dbt models, snapshots, and exposures #}
  {% set referenced_nodes = [] %}
  {% for node in graph.nodes.values() %}
    {# Check if the current node is of a type that should be referenced #}
    {% if node.resource_type in reference_resource_types %}
      {# Get nodes that the current node depends on #}
      {% set dependent_nodes = node.depends_on.nodes %}

      {# If there are dependent nodes, iterate over them #}
      {% if dependent_nodes is not none and dependent_nodes|length > 0 %}
        {% for dependent_node in dependent_nodes %}
          {# If the dependent node is a source, mark it as referenced #}
          {% if dependent_node in all_sources %}
            {% do all_sources.update({dependent_node: true}) %}
          {% endif %}
        {% endfor %}
      {% endif %}

    {% endif %}
  {% endfor %}

  {# Select unreferenced sources #}
  {% set unreferenced_sources = []%}
  {% for unique_id, is_referenced in all_sources.items() %}
    {% if is_referenced is false %}
      {% do unreferenced_sources.append(unique_id) %}
    {% endif %}
  {% endfor %}

  {{ return(unreferenced_sources) }}
{% endmacro %}
