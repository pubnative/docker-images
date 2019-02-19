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
  env = {
    DOCKER_USERNAME = "deployments"
    DOCKER_PASSWORD = "DvrAyre#%!"
  }
}

action "Release android docker image" {
  uses = "actions/docker/cli@master"
  needs = ["Docker registry login"]
  args = "push -t pubnative/android:$(echo $GITHUB_REF | cut -c19-)"
}

