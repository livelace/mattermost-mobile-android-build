properties([
        parameters([
                choice(choices: ['release-1.40'], name: 'BRANCH'),
                string(defaultValue: '60', name: 'TIMEOUT')
        ])])


utils_check_first_run()

def secret = [
        ["BUILD_CONF", "secret/app/mattermost-mobile-android", "conf"],
        ["BUILD_FIREBASE", "secret/app/mattermost-mobile-android", "firebase"],
        ["BUILD_KEYSTORE", "secret/app/mattermost-mobile-android", "keystore"]
]

//k8s_build(secret)