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

k8s_build()