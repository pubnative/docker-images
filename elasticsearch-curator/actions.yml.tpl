# https://www.elastic.co/guide/en/elasticsearch/client/curator/current/actionfile.html

actions:
  {% for i in range(ES_ACTIONS_COUNT | from_json) %}
  {{ i }}:
    {% for key, value in environment('ES_ACTIONS_%d_' % i) %}
    {{ key }}: {{ value }}
    {% endfor %}
  {% endfor %}
