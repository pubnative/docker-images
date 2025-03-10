FROM alpine:3.12
RUN apk -v --update add \
        python3 \
        curl \
        bash && \
    curl https://sdk.cloud.google.com | CLOUDSDK_CORE_DISABLE_PROMPTS=1 bash && \
    echo "source /root/google-cloud-sdk/path.bash.inc" > ~/.bashrc && \
    /root/google-cloud-sdk/bin/gcloud config set disable_usage_reporting false && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/*
ENTRYPOINT ["/bin/bash"]
