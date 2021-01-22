# Image: pubnative/airflow-bi:1.1

FROM pubnative/airflow:python3.7

LABEL maintainer Data Team <data@pubnative.net>

ENV AIRFLOW_VERSION "1.10.7"
ENV INFLUX_DB_VERSION "5.2.1"
ENV WERKZEUG_VERSION "0.15.4"

LABEL maintainer Denis <denis@pubnative.net>

RUN pip3 install \
  --upgrade \
  apache-airflow[statsd]==${AIRFLOW_VERSION} \
  influxdb==${INFLUX_DB_VERSION} \
  werkzeug==${WERKZEUG_VERSION}

RUN pip install \
 --upgrade\
 bs4 \
 boto3 \
 django-smtp-ssl \
 fastparquet \
 google-cloud-storage \
 gspread \
 gspread_pandas \
 lxml \
 matplotlib \
 oauth2client \
 openpyxl \
 "pandas==0.24.1" \
 pandas_explode \
 pyarrow \
 pyathena \
 pydruid \
 pygsheets \
 pyhive \
 python-dotenv \
 ratelimiter \
 requests \
 s3fs \
 send_email \
 scipy \
 slack \
 slackclient \
 sqlalchemy \
 twilio \
 "websocket-client==0.55.0" \
 xlrd \
 xlsxwriter \
 "gcsfs==0.7.1"
