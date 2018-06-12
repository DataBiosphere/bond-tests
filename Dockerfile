FROM python:2.7.15

# man directory is missing in some base images
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863199
RUN apt-get update \
  && mkdir -p /usr/share/man/man1 \
  && apt-get install -y \
    git mercurial xvfb \
    locales sudo openssh-client ca-certificates tar gzip parallel \
    net-tools netcat unzip zip bzip2 gnupg curl wget

# Set timezone to UTC by default
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

# install gcloud sdk
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz
RUN mkdir -p /usr/local/gcloud
RUN tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz
RUN /usr/local/gcloud/google-cloud-sdk/install.sh --quiet
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

# install App Engine original local development server
RUN curl https://storage.googleapis.com/appengine-sdks/featured/google_appengine_1.9.70.zip > tmp/google-appengine-sdk.zip
RUN mkdir -p /usr/local/google_appengine
RUN unzip tmp/google-appengine-sdk.zip -d /usr/local
ENV PATH $PATH:/usr/local/google_appengine

# Install pipenv
RUN sudo pip install pipenv

CMD ["/bin/sh"]
