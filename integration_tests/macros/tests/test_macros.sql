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

{% macro test_macros() %}
  {{- return(adapter.dispatch("test_macros", "integration_tests")()) -}}
{% endmacro %}

{% macro default__test_macros() %}
  {% do integration_tests.test_get_node_by_unique_id() %}


  {% do integration_tests.test_build_dependenncy_adjacency_list() %}

  {% do integration_tests.test_transpose_adjacency_list() %}

  {% do integration_tests.test_get_node_dependency_from_adjacency_list() %}

  {% do integration_tests.test_find_unrendered_sources() %}
{% endmacro %}
