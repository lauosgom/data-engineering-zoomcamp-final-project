{% macro strip_code_prefix(column_name) %}
REGEXP_REPLACE({{ column_name }}, r'^[A-Za-z0-9]+\s*-\s*', '')
{% endmacro %}