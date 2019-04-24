FROM circleci/ruby:2.5.5-stretch-node

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential ca-certificates fontforge git python zlib1g zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

RUN git clone --recursive https://github.com/google/woff2.git /tmp/woff2 \
  && cd /tmp/woff2 \
  && make clean all \
  && mv woff2_compress /usr/local/bin/ \
  && mv woff2_decompress /usr/local/bin/
RUN git clone -b master --single-branch --depth=1 https://github.com/bramstein/sfnt2woff-zopfli.git /tmp/sfnt2woff-zopfli\
  && cd /tmp/sfnt2woff-zopfli \
  && make \
  && mv sfnt2woff-zopfli /usr/local/bin/sfnt2woff

USER circleci

RUN gem install fontcustom
