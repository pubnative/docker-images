workflow "Release android docker" {
  on = "push"
  resolves = ["Build android image"]
}

action "Check android tag" {
  uses = "actions/bin/filter@master"
  args = "tag android-*"
}

action "Build android image" {
  uses = "actions/docker/cli@master"
  needs = ["Filter"]
  args = "build -f android/Dockerfile -t pubnative/android:$(echo $GITHUB_REF | cut -c19-) android"
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
  args = "push -t pubnative/android:$(echo $GITHUB_REF | cut -c19-)"
}

