<match json.**>
  @type parser
  remove_prefix json
  key_name ${OUTPUT_JSON_KEY_NAME}
  reserve_data yes
  format json
</match>
