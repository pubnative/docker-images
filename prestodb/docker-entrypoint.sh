#!/bin/sh -x

for template_path in /etc/presto/*.tpl ; do
  echo $template_path
  envtpl $template_path
done

cat /etc/presto/*

exec "$@"
