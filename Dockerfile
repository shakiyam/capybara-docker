FROM ruby:2.7-alpine3.15
WORKDIR /root
COPY Gemfile /root/
COPY Gemfile.lock /root/
# hadolint ignore=DL3018
RUN apk add --no-cache xz-dev libxml2-dev libxslt-dev \
  && apk add --no-cache --virtual=.build-dependencies g++ gcc make \
  && bundle config build.nokogiri --use-system-libraries \
  && bundle install \
  && rm -rf /root/.bundle/cache \
  && rm -rf /usr/local/bundle/cache/*.gem \
  && find /usr/local/bundle/gems/ -regex ".*\.[cho]" -delete \
  && apk del --purge .build-dependencies
WORKDIR /work
VOLUME /work
ENTRYPOINT ["rspec"]
CMD ["-O", "/dev/null", "-fd"]
