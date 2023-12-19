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

{% macro get_nodes(resource_type) %}
  {# NOTE if specifications of macros are changed in the future, we will support multiple versions. #}

  {% do return(dbt_data_privacy.get_nodes_v1(resource_type)) %}
{% endmacro %}

{% macro get_nodes_v1(resource_type) %}
  {% if resource_type == "source" %}
    {% set nodes = graph.sources.values() %}
    {% do return(nodes) %}
  {% else %}
    {% set nodes = graph.nodes.values()
        | selectattr("resource_type", "equalto", resource_type) %}
    {% do return(nodes) %}
  {% endif %}
{% endmacro %}
