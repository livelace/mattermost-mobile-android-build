FROM            ruby:2.7.1-slim

ENV             ANDROID_COMMAND_LINE_TOOLS_URL="https://dl.google.com/android/repository/commandlinetools-linux-6200805_latest.zip"
ENV             ANDROID_HOME="/opt/android/sdk"
ENV             ANDROID_ACCEPT_LICENSE="yes"
ENV             ANDROID_PLATFORM_VERSION="24"
ENV             DEBIAN_FRONTEND="noninteractive"
ENV		        LANG="en_US.UTF-8"
ENV		        LANGUAGE="en_US.UTF-8"
ENV		        PATH=$PATH:/home/builder/.gem/ruby/2.7.0/bin:/opt/android/sdk/platform-tools:/opt/android/tools/bin

RUN             mkdir -p "/usr/share/man/man1" && \
		        apt-get update --fix-missing && \
                apt-get -y upgrade && \
                apt-get install -y \
                apt-transport-https \
		        build-essential \
		        default-jdk-headless \
                curl \
		        git \
		        python3 \
		        unzip \
		        usbutils \
		        vim

RUN             echo "deb https://deb.nodesource.com/node_12.x buster main" > "/etc/apt/sources.list.d/nodesource.list" && \
		        echo "deb-src https://deb.nodesource.com/node_12.x buster main" >> "/etc/apt/sources.list.d/nodesource.list" && \
		        curl -sSL "https://deb.nodesource.com/gpgkey/nodesource.gpg.key" | apt-key add - && \
                apt-get update && \
                apt-get install -y nodejs

RUN		        useradd -m builder && \
		        mkdir -p "/opt/android" && \
		        chown builder "/opt/android"

USER		    builder

RUN		        curl "$ANDROID_COMMAND_LINE_TOOLS_URL" -o "/tmp/android-tools.zip"  && \
		        unzip -d "/opt/android" "/tmp/android-tools.zip"; rm -f "/tmp/android-tools.zip" && \
		        $ANDROID_ACCEPT_LICENSE | sdkmanager  --sdk_root="/opt/android/sdk" "platform-tools" "platforms;android-${ANDROID_PLATFORM_VERSION}"

RUN		        gem install --user-install fastlane

COPY            "build-sample.conf" "/home/builder/build-sample.conf"

COPY            "entrypoint.sh" "/entrypoint.sh"

ENTRYPOINT      ["/entrypoint.sh"]

CMD             ["help"]
