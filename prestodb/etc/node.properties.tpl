# node.properties
{% for key, value in environment('NODE_') %}{{ key }}={{ value }}
{% endfor %}
