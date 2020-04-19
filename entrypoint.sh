#!/usr/bin/env bash

#------------------------------------------------------------------------------

MATTERMOST_MOBILE_GIT_URL="https://github.com/mattermost/mattermost-mobile.git"

CONF_PATH="/conf"
DATA_PATH="/data"

BUILD_CONF_SAMPLE="build-sample.conf"
BUILD_CONF_SAMPLE_FILE="/home/builder/${BUILD_CONF_SAMPLE}"

BUILD_CONF="build.conf"
BUILD_CONF_FILE="${CONF_PATH}/${BUILD_CONF}"

GOOGLE_SERVICE="google-services.json"
GOOGLE_SERVICE_FILE="${CONF_PATH}/${GOOGLE_SERVICE}"

KEYSTORE="android-apk-signing.keystore"
KEYSTORE_FILE="${CONF_PATH}/${KEYSTORE}"

#------------------------------------------------------------------------------

if [[ "$@" =~ help ]];then
HELP_CONTENT=$(cat<<EOF

Usage:

init            - Initialize build configuration.
build           - Build Mattermost mobile client.
clean           - Clean produced data during build (doesn't affect configuration).
shell           - Execute shell (useful for debugging and customization).

EOF
)
    echo "$HELP_CONTENT"
    exit 0
fi

#------------------------------------------------------------------------------

ACTION="$1"

#------------------------------------------------------------------------------

if [[ "$ACTION" = "init" ]];then
    cp "$BUILD_CONF_SAMPLE_FILE" "/${CONF_PATH}/${BUILD_CONF_SAMPLE}"

    echo "INFO: Sample build configuration file was placed into configuration directory."

    exit 0

elif [[ "$ACTION" = "build" ]];then

    if [[ ! -f "$BUILD_CONF_FILE" ]];then
        echo "ERROR: Cannot find build configuration: \"${BUILD_CONF}\""
        exit 1
    elif [[ ! -f "$GOOGLE_SERVICE_FILE" ]]; then
        echo "ERROR: Cannot find firebase app configuration: \"${GOOGLE_SERVICE}\""
        exit 1
    elif [[ ! -f "$KEYSTORE_FILE" ]]; then
        echo "ERROR: Cannot find keystore for app signing: \"${KEYSTORE}\""
        exit 1
    else
        # Load build variables.
        source "$BUILD_CONF_FILE"

        # Construct some variables.
        TARGET_DIR="${DATA_PATH}/${BRANCH_TO_BUILD}/mattermost-mobile"

        # Add keystore properties into "gradle.properties".
        mkdir "/home/builder/.gradle"

        echo "MATTERMOST_RELEASE_STORE_FILE=$KEYSTORE_FILE" > "/home/builder/.gradle/gradle.properties"
        echo "MATTERMOST_RELEASE_KEY_ALIAS=$MATTERMOST_RELEASE_KEY_ALIAS" >> "/home/builder/.gradle/gradle.properties"
        echo "MATTERMOST_RELEASE_PASSWORD=$MATTERMOST_RELEASE_PASSWORD" >> "/home/builder/.gradle/gradle.properties"

        # Fetch app sources.
        rm -rf "$TARGET_DIR"
        git clone --single-branch --branch "$BRANCH_TO_BUILD" "$MATTERMOST_MOBILE_GIT_URL" "$TARGET_DIR"

        cd "$TARGET_DIR"

        # Replace "project_number" in "AndroidManifest.xml".
        PROJECT_NUMBER=$(grep -oP '"project_number": "\K\d+' $GOOGLE_SERVICE_FILE)
        sed -i "s|184930218130|$PROJECT_NUMBER|" "android/app/src/main/AndroidManifest.xml"

        # Replace FCM configuration.
        cat $GOOGLE_SERVICE_FILE > "android/app/google-services.json"

        # Install dependencies.
        cd "$TARGET_DIR/fastlane"
        bundle

        cd "$TARGET_DIR"

        # Build app.
        make pre-build
        make build-android

    fi

    exit 0

elif [[ "$ACTION" = "clean" ]];then
    echo "INFO: Perform cleanup. You have 10 seconds to change your mind [CTRL+C] ..."
    sleep 10
    rm -rf /data/* /data/.* >/dev/null 2>&1

elif [[ "$ACTION" = "shell" ]];then
    exec /bin/bash

else
    echo "ERROR: Unknown action: ${ACTION}"
    exit 1
fi



#------------------------------------------------------------------------------
