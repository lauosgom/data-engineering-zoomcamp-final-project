{% macro categorize_duracion(column_name) %}
CASE
    WHEN {{ column_name }} BETWEEN 1 AND 5   THEN '1-5 min'
    WHEN {{ column_name }} BETWEEN 6 AND 10  THEN '6-10 min'
    WHEN {{ column_name }} BETWEEN 11 AND 20 THEN '11-20 min'
    WHEN {{ column_name }} BETWEEN 21 AND 30 THEN '21-30 min'
    WHEN {{ column_name }} > 30              THEN '+30 min'
    ELSE NULL
END
{% endmacro %}