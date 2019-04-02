workflow "Release android docker" {
  on = "create"
  resolves = ["Release android docker image"]
}

action "Check android tag" {
  uses = "actions/bin/filter@master"
  args = "tag android-*"
}

action "Build android image" {
  uses = "actions/docker/cli@master"
  needs = ["Check android tag"]
  args = "build -f android/Dockerfile -t pubnative/android:$(echo $GITHUB_REF | cut -c19-) android"
}

action "Docker registry login" {
  uses = "actions/docker/login@master"
  needs = ["Build android image"]
}

action "Release android docker image" {
  uses = "actions/docker/cli@master"
  needs = ["Docker registry login"]
  args = "push pubnative/android:$(echo $GITHUB_REF | cut -c19-)"
}

workflow "Release mysql-rds-replicator docker" {
  on = "create"
  resolves = ["Release pubnative/mysql-rds-replicator docker image"]
}

action "Check mysql-rds-replicator tag" {
  uses = "actions/bin/filter@master"
  args = "tag mysql-rds-replicator-*"
}

action "Build mysql-rds-replicator image" {
  uses = "actions/docker/cli@master"
  needs = ["Check mysql-rds-replicator tag"]
  args = "build --build-arg MYSQL_VERION=$(echo $GITHUB_REF | cut -c22-) -f mysql-rds-replicator/Dockerfile -t pubnative/mysql-rds-replicator:$(echo $GITHUB_REF | cut -c22-) mysql-rds-replicator"
}

action "Docker registry login" {
  uses = "actions/docker/login@master"
  needs = ["Build mysql-rds-replicator image"]
}

action "Release mysql-rds-replicator docker image" {
  uses = "actions/docker/cli@master"
  needs = ["Docker registry login"]
  args = "push pubnative/mysql-rds-replicator:$(echo $GITHUB_REF | cut -c22-)"
}
