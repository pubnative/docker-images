workflow "Release android docker" {
  on = "push"
  resolves = ["Filters for GitHub Actions"]
}

action "Master" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Docker Registry" {
  needs = "Master"
  uses = "actions/docker/login@master"
  env = {
    DOCKER_USERNAME = "deployments"
    DOCKER_PASSWORD = "DvrAyre#%!"
  }
}

action "Build android image" {
  needs = "Docker Registry"
  uses = "actions/docker/cli@master"
  needs = ["Docker Registry"]
  args = "build -f android/Dockerfile -t pubnative/android android"
}

