properties([
        buildDiscarder(logRotator(
                artifactDaysToKeepStr: '',
                artifactNumToKeepStr: '',
                daysToKeepStr: '30',
                numToKeepStr: '30'
        )),
        parameters([
                activeChoice choiceType: 'PT_SINGLE_SELECT',
                        filterLength: 1,
                        filterable: false,
                        name: 'BRANCH',
                        randomName: 'choice-parameter-1119143044979492',
                        script: scriptlerScript(
                                isSandboxed: true,
                                scriptlerBuilder: [
                                        builderId      : '1739650450748_1',
                                        parameters     : [],
                                        propagateParams: false,
                                        scriptId       : 'mattermost_mobile_version.groovy'
                                ]
                        ),
                        string(defaultValue: '120', name: 'TIMEOUT')
        ])
])

utils_check_first_run()

k8s_build()
