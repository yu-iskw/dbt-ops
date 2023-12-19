{#
  Get the nodes that the given node depends on
#}

{% macro get_node_depends_on(node) %}
  {% if node.depends_on is defined and node.depends_on.nodes is defined %}
    {{ return(node.depends_on.nodes) }}
  {% else %}
    {{ return(none) }}
  {% endif %}
{% endmacro %}
