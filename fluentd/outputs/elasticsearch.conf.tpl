<match **>
  @type elasticsearch
  logstash_format true
  hosts ${ES_HOST}
  index_name ${ES_INDEX}
  logstash_prefix ${ES_INDEX_PREFIX}
  logstash_dateformat %Y.%m.%d
  reload_on_failure true
  include_tag_key true
  tag_key _tag
</match>
