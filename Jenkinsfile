properties([
    buildDiscarder(logRotator(
        artifactDaysToKeepStr: '',
        artifactNumToKeepStr: '',
        daysToKeepStr: '30',
        numToKeepStr: '30'
    )),
    parameters([
        [
            $class              : 'CascadeChoiceParameter',
            choiceType          : 'PT_SINGLE_SELECT',
            description         : null,
            filterLength        : 1,
            filterable          : false,
            name                : 'BRANCH',
            randomName          : 'choice-parameter-245877844563629',
            referencedParameters: '',
            script              : [$class: 'ScriptlerScript', parameters: [], scriptlerScriptId: 'mattermost_mobile_version.groovy']
        ],
        string(defaultValue: '120', name: 'TIMEOUT')
    ])
])

utils_check_first_run()

//k8s_build()
