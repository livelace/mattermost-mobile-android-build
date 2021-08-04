def VERSIONS = [
    'release-1.46',
    'release-1.45',
    'release-1.40'
]

properties([
        parameters([
                choice(choices: VERSIONS, name: 'BRANCH'),
                string(defaultValue: '120', name: 'TIMEOUT')
        ])])


utils_check_first_run()

def secret = [
        ["BUILD_CONF", "secret/app/mattermost-mobile-android", "conf"],
        ["BUILD_FIREBASE", "secret/app/mattermost-mobile-android", "firebase"],
        ["BUILD_KEYSTORE", "secret/app/mattermost-mobile-android", "keystore"]
]

k8s_build(secret)