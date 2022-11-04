def TIMEOUT = env.TIMEOUT ? env.TIMEOUT.toInteger() : 120

libraries {
    git {
        repo_url = "https://github.com/livelace/mattermost-mobile-android-build.git"
    }
//     harbor {
//         policy = "mattermost-mobile-android-build"
//     }
    k8s_build {
        image = "harbor-core.k8s-2.livelace.ru/dev/mattermost-mobile-android-build:latest"
        force_pull = true

        secret = """
            env, BUILD_CONF, secret/app/mattermost-mobile-android, conf
            env, BUILD_FIREBASE, secret/app/mattermost-mobile-android, firebase
            env, BUILD_KEYSTORE, secret/app/mattermost-mobile-android, keystore
        """

        timeout = TIMEOUT
    }
//     kaniko {
//         context = "/tmp/job/work"
//         destination = "dev/mattermost-mobile-android-build:latest"
//     }
    mattermost
    nexus {
        source = "/data/${env.BRANCH}/mattermost-mobile/matterlace.apk"
        destination = "dists-internal/matterlace/matterlace-${env.BRANCH}.apk"
        ignore_ssl = true
    }
    shell {
        build = """
            echo \$BUILD_CONF | base64 -d > /conf/build.conf && \
            echo \$BUILD_FIREBASE | base64 -d > /conf/google-services.json && \
            echo \$BUILD_KEYSTORE | base64 -d > /conf/android-apk-signing.keystore && \

            sed -i "s|<BRANCH>|${env.BRANCH}|g" /conf/build.conf && \

            /entrypoint.sh build
        """

        timeout = TIMEOUT
    }
    utils
}
