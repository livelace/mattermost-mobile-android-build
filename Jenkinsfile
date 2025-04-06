properties([
    buildDiscarder(logRotator(
        artifactDaysToKeepStr: '',
        artifactNumToKeepStr: '',
        daysToKeepStr: '30',
        numToKeepStr: '30'
    )),
    parameters([
        string(defaultValue: 'release-2.26', name: 'BRANCH'),
        string(defaultValue: '120', name: 'TIMEOUT')
    ])
])

utils_check_first_run()

k8s_build()
