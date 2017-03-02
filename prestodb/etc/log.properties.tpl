# log.properties
{% for key, value in environment('LOG_') %}{{ key }}={{ value }}
{% endfor %}
