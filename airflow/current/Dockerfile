# Images:
#  - pubnative/airflow:latest
#  - pubnative/airflow:plugins-${GIT_COMMIT}
# 
# C.f. Makefile

FROM pubnative/airflow:plugins-1.4

RUN pip install \
 --force-reinstall \
 boto3==1.10.40 \
 pyathena==1.9.0 \
 pyyaml==5.3