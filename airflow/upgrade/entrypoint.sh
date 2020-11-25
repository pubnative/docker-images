#!/usr/bin/env bash

function init_gcloud {
  EMAIL=${GCP_AIRFLOW_ACCOUNT_EMAIL:?"Need to be set and non-empty"}
  FILE=${GCP_AIRFLOW_SA_FILE_PATH:?"Need to be set and non-empty"}
  LOCATION=${GCP_K8S_LOCATION:?"Need to be set and non-empty"}
  ZONE=${GCP_K8S_ZONE:?"Need to be set and non-empty"}
  PROJECT=${GCP_K8S_PROJECT:?"Need to be set and non-empty"}
  
  #Start gcloud auth
  gcloud auth activate-service-account $EMAIL --key-file $FILE
  #Create the kubeconfig
  gcloud container clusters get-credentials $LOCATION  --zone $ZONE  --project $PROJECT
} 

while getopts ":hwsig" opt; do
  case ${opt} in
    h )
      echo "Usage:"
      echo "    docker run <image> -h          Display this help message."
      echo "    docker run <image> -w          Start airflow as a webserver"
      echo "    docker run <image> -s          Start airflow as a scheduler"
      echo "    docker run <image> -w -g       Start airflow as a webserver with gcloud credentials"
      echo "    docker run <image> -s -g       Start airflow as a scheduler with gcloud credentials"
      exit 0
      ;;
    w )
      echo "Start as a webserver"
      OPERATOR="webserver"
      ;;
    s )
      echo "Start as a scheduler"
      OPERATOR="scheduler"
      ;;
    i )
      echo "Start as a initdb"
      OPERATOR="initdb"
      ;;
    g )
      echo "Gcloud auth and creates kubeconfig"
      init_gcloud
      ;;
    \? )
      echo "Invalid Option: -$OPTARG" 1>&2
      exit 1
      ;;
  esac
done

echo "Starting airflow as $OPERATOR"
airflow $OPERATOR
