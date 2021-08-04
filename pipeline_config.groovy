libraries {
    git {
        repo_url = "https://github.com/livelace/mattermost-mobile-android-build.git"
    }
    kaniko {
        destination = "infra/mattermost-mobile-android-build:latest"
    }
    mattermost
}
