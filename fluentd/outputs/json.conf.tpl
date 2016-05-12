<match json.docker.**>
  @type parser
  remove_prefix json
  key_name log
  reserve_data yes
  format json
</match>
