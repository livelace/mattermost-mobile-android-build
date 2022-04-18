def VERSIONS = [
    'release-1.50',
    'release-1.49',
    'release-1.48',
    'release-1.46',
    'release-1.45',
    'release-1.40'
]

properties([
    buildDiscarder(logRotator(
        artifactDaysToKeepStr: '',
        artifactNumToKeepStr: '',
        daysToKeepStr: '30',
        numToKeepStr: '30'
    )),
    parameters([
            choice(choices: VERSIONS, name: 'BRANCH'),
            string(defaultValue: '120', name: 'TIMEOUT')
    ])
])

utils_check_first_run()

k8s_build()
