FROM ghcr.io/ruby/ruby:3.2-jammy AS builder
ENV GEM_HOME=/usr/local/bundle
WORKDIR /root
COPY Gemfile /root/
COPY Gemfile.lock /root/
# hadolint ignore=DL3008
RUN apt-get update \
  && apt-get -y --no-install-recommends install g++ make \
  && rm -rf /var/lib/apt/lists/* \
  && bundle install \
  && rm -rf /root/.bundle/cache \
  && rm -rf /usr/local/bundle/cache/*.gem \
  && find /usr/local/bundle/gems/ -regex ".*\.[cho]" -delete

FROM ghcr.io/ruby/ruby:3.2-jammy
ENV GEM_HOME=/usr/local/bundle
ENV PATH $GEM_HOME/bin:$PATH
COPY --from=builder /usr/local/bundle /usr/local/bundle
WORKDIR /work
VOLUME /work
USER nobody:nogroup
ENTRYPOINT ["rspec"]
CMD ["-O", "/dev/null", "-fd"]
