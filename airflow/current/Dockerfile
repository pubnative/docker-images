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

# Install gcloud
ENV CLOUDSDK_INSTALL_DIR /usr/local/gcloud/
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

#Install kubectl
RUN  gcloud components install kubectl

#Copy the new entrypoint and define it as entrypoint
COPY ./entrypoint.sh  /entrypoint.sh
ENTRYPOINT [ "./entrypoint.sh" ]
