libraries {
    git {
        repo_url = "https://github.com/livelace/mattermost-mobile-android-build.git"
    }
    k8s_build {
        image = "harbor-core.k8s-2.livelace.ru/dev/mattermost-mobile-android-build:latest"
    }
//     kaniko {
//         context = "/tmp/job/work"
//         destination = "dev/mattermost-mobile-android-build:latest"
//     }
    mattermost
    shell {
        build = """
            mkdir -p /conf /data

            echo \$BUILD_CONF | base64 -d > /conf/build.conf
            echo \$BUILD_FIREBASE | base64 -d > /conf/google-services.json
            echo \$BUILD_KEYSTORE | base64 -d > /conf/android-apk-signing.keystore

            sed -i "s|<BRANCH>|release-1.40|g" /conf/build.conf

            /entrypoint.sh build
        """
    }
}
