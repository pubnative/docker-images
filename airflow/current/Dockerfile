# Images:
#  - pubnative/airflow:latest
#  - pubnative/airflow:plugins-${GIT_COMMIT}
# 
# C.f. Makefile

FROM pubnative/airflow:plugins-1.4

COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

# Install gcloud
ENV CLOUDSDK_INSTALL_DIR /usr/local/gcloud/
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

# Install kubectl
RUN  gcloud components install kubectl

# Copy the new entrypoint and define it as entrypoint
COPY ./entrypoint.sh  /start/entrypoint.sh
RUN chmod +x /start/entrypoint.sh

ENTRYPOINT [ "/start/entrypoint.sh" ]
CMD [ "-h" ]