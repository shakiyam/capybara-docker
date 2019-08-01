FROM ruby:alpine
WORKDIR /root
COPY Gemfile /root/
COPY Gemfile.lock /root/
RUN apk update \
  && apk add --no-cache --virtual=.build-dependencies g++ gcc libxml2-dev libxslt-dev make \
  && bundle install \
  && rm -rf /root/.bundle/cache \
  && rm -rf /usr/local/bundle/cache/*.gem \
  && find /usr/local/bundle/gems/ -name "*.c" -delete \
  && find /usr/local/bundle/gems/ -name "*.o" -delete \
  && apk del .build-dependencies
WORKDIR /work
VOLUME /work
ENTRYPOINT ["rspec"]
CMD ["-O", "/dev/null", "-fd"]
