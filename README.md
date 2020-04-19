## Description:

This project is a Docker image for building [Android version](https://play.google.com/store/apps/details?id=com.mattermost.rn) of [Mattermost Mobile Client](https://github.com/mattermost/mattermost-mobile). The primary audience - persons who want to have their own [Mobile Push Notifications](https://developers.mattermost.com/contribute/mobile/push-notifications/) (you will use Google servers anyway, but those notifications don't contain messages' text itself).

## Usage:

**Prepare working directories:**

```bash
mkdir conf data
chmod 777 conf data
```

**Get help information:**

```bash
docker run -ti --rm \
    -v $(pwd)/conf:/conf \
    -v $(pwd)/data:/data \
    livelace/mattermost-mobile-android-build help
```

**Generate keystore file (for APK signing):**

```bash
keytool -genkey -v -keystore conf/android-apk-signing.keystore \
  -alias <KEY_ALIAS> -keyalg RSA -keysize 2048 -validity 10000 
```

**Place FCM ([Firebase Cloud Messaging](https://en.wikipedia.org/wiki/Firebase_Cloud_Messaging)) configuration ([how to get one](https://developers.mattermost.com/contribute/mobile/push-notifications/android/)):**

```bash
cp google-services.json conf/google-services.json
```

**Initialize configuration:**

```bash
docker run -ti --rm \
    -v $(pwd)/conf:/conf \
    -v $(pwd)/data:/data \
    livelace/mattermost-mobile-android-build init
```

**Edit configuration:**

```bash
cp conf/build-sample.conf conf/build.conf 
vim conf/build.conf
```

**Build application:**

```bash
docker run -ti --rm \
    -v $(pwd)/conf:/conf \
    -v $(pwd)/data:/data \
    livelace/mattermost-mobile-android-build build
```

**Install application:**

```bash
adb install data/<BRANCH_TO_BUILD>/mattermost-mobile/<APP_NAME>.apk
```

**Clean produced data:**

```bash
docker run -ti --rm \
    -v $(pwd)/conf:/conf \
    -v $(pwd)/data:/data \
    livelace/mattermost-mobile-android-build clean
```

