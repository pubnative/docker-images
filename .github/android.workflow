workflow "Release android docker" {
  on = "push"
  resolves = ["Build android image"]
}

action "Filter" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Build android image" {
  uses = "actions/docker/cli@master"
  needs = ["Filter"]
  args = "build -f android/Dockerfile -t pubnative/android:$GITHUB_SHA android"
}

action "Docker Registry" {
  uses = "actions/docker/login@master"
  needs = ["Filter"]
  env = {
    DOCKER_USERNAME = "deployments"
    DOCKER_PASSWORD = "DvrAyre#%!"
  }
}

action "Push" {
  uses = "actions/docker/cli@master"
  needs = ["Docker Registry"]
  args = "push -t pubnative/android:$GITHUB_SHA"
}

