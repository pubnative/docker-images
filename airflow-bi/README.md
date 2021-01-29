# Airflow BI

Image used for our Airflow BI deployment. It builds one image and tags it as:

- `pubnative/airflow-bi:latest`,
- `pubnative/airflow-bi:${GIT_COMMIT}`

Where `${GIT_COMMIT}` is the first seven characters of the git commit.

## Build

To build the image, you will need [poetry](https://python-poetry.org/).

`make -C airflow-bi build`

## Deploy

`make -C airflow-bi push`

## Both

`make -C airflow-bi`
