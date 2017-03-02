# config.properties
{% for key, value in environment('CONFIG_') %}{{ key }}={{ value }}
{% endfor %}
