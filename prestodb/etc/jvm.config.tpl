# jvm.config
{% for i in JAVA_OPTS.split(' ') %}{{i}}
{% endfor %}
-XX:G1HeapRegionSize=32M
-XX:+UseGCOverheadLimit
-XX:+ExplicitGCInvokesConcurrent
-XX:OnOutOfMemoryError=kill -9 %p

