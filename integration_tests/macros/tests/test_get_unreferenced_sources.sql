{% macro test_get_unrendered_sources() %}
  {% set unreferenced_sources = dbt_ops.__get_unreferenced_sources() %}
  {% do assert_equals(unreferenced_sources | length, 1) %}
{% endmacro %}
