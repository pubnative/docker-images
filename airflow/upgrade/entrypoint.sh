while getopts ":hwsi" opt; do
  case ${opt} in
    h )
      echo "Usage:"
      echo "    ./entrypoint.sh -h          Display this help message."
      echo "    ./entrypoint.sh -w          Start airflow as a webserver"
      echo "    ./entrypoint.sh -s          Start airflow as a scheduler"
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
    \? )
      echo "Invalid Option: -$OPTARG" 1>&2
      exit 1
      ;;
  esac
done

if [ -z "$GCP_AIRFLOW_ACCOUNT_EMAIL" ]
then
      echo "\$GCP_AIRFLOW_ACCOUNT_EMAIL is empty. It is required."
      exit 1
fi

if [ -z "$GCP_AIRFLOW_SA_FILE_PATH" ]
then
      echo "\$GCP_AIRFLOW_SA_FILE_PATH is empty. It is required."
      exit 1
fi

if [ -z "$GCP_K8S_LOCATION" ]
then
      echo "\$GCP_K8S_LOCATION is empty. It is required."
      exit 1
fi

if [ -z "$GCP_K8S_ZONE" ]
then
      echo "\$GCP_K8S_ZONE is empty. It is required."
      exit 1
fi

if [ -z "$GCP_K8S_PROJECT" ]
then
      echo "\$GCP_K8S_PROJECT is empty. It is required."
      exit 1
fi

gcloud auth activate-service-account $GCP_AIRFLOW_ACCOUNT_EMAIL --key-file $GCP_AIRFLOW_SA_FILE_PATH

gcloud container clusters get-credentials $GCP_K8S_LOCATION  --zone $GCP_K8S_ZONE --project $GCP_K8S_PROJECT

airflow $OPERATOR