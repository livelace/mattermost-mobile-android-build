libraries {
    git {
        repo_url = "https://github.com/livelace/mattermost-mobile-android-build.git"
    }
    k8s_build
    kaniko {
        destination = "dev/mattermost-mobile-android-build:latest"
    }
    mattermost
}
