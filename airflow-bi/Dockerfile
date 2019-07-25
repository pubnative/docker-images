# Image: pubnative/airflow-bi:1.0

FROM pubnative/airflow:python3.7

RUN pip install \
      "pandas==0.24.1" \
      sqlalchemy \
      pyhive \
      gspread \
      requests \
      pygsheets \
      oauth2client \
      twilio \
      boto3 \
      google-cloud-storage \
      scipy \
      bs4 \
      matplotlib \
      lxml \
      xlsxwriter \
      pydruid \
      openpyxl \
      "websocket-client==0.55.0" \
      "slackclient==1.3.0" \
      --upgrade pip \
      xlrd \
      fastparquet \
      pyarrow \
      s3fs

LABEL maintainer Denis <denis@pubnative.net>
