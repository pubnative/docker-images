# https://www.elastic.co/guide/en/elasticsearch/client/curator/current/configfile.html

client:
{% for key, value in environment('ES_CLIENT_') %}
  {{ key }}: {{ value }}
{% endfor %}

logging:
{% for key, value in environment('ES_LOGGING_') %}
  {{ key }}: {{ value }}
{% endfor %}

