#!/usr/bin/env bash

function init_gcloud {
  EMAIL=${GCP_AIRFLOW_ACCOUNT_EMAIL:?"Need to be set and non-empty"}
  FILE=${GCP_AIRFLOW_SA_FILE_PATH:?"Need to be set and non-empty"}
  LOCATION=${GCP_K8S_LOCATION:?"Need to be set and non-empty"}
  ZONE=${GCP_K8S_ZONE:?"Need to be set and non-empty"}
  PROJECT=${GCP_K8S_PROJECT:?"Need to be set and non-empty"}
  
  # Start gcloud auth
  gcloud auth activate-service-account $EMAIL --key-file $FILE
  # Create the kubeconfig
  gcloud container clusters get-credentials $LOCATION  --zone $ZONE  --project $PROJECT
} 


echo "Authenticates Gcloud and creates a kube config file"
init_gcloud

