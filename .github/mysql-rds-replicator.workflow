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
  args = "build --build-arg MYSQL_VERION=$(echo $GITHUB_REF | cut -c19-) -f mysql-rds-replicator/Dockerfile -t pubnative/mysql-rds-replicator:$(echo $GITHUB_REF | cut -c19-) mysql-rds-replicator"
}

action "Docker registry login" {
  uses = "actions/docker/login@master"
  needs = ["Build mysql-rds-replicator image"]
}

action "Release mysql-rds-replicator docker image" {
  uses = "actions/docker/cli@master"
  needs = ["Docker registry login"]
  args = "push pubnative/mysql-rds-replicator:$(echo $GITHUB_REF | cut -c19-)"
}
