{% macro test_macros() %}
  {{- return(adapter.dispatch("test_macros", "integration_tests")()) -}}
{% endmacro %}

{% macro default__test_macros() %}
  {% do integration_tests.test_get_unrendered_sources() %}
{% endmacro %}
