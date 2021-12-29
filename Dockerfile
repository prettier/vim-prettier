FROM alpine:3.8 as builder

WORKDIR /tmp

RUN apk add --no-cache \
  build-base \
  ctags \
  git \
  libx11-dev \
  libxpm-dev \
  libxt-dev \
  libxtst-dev \
  make \
  ncurses-dev \
  python3 \
  python3-dev \
  perl-dev \
  ruby-dev

RUN git clone https://github.com/vim/vim && cd vim \
  && ./configure \
  --with-features=huge \
  --with-x \
  --with-compiledby=mitermayer.reis@gmail.com \
  && make install

FROM testbed/vim:latest

COPY --from=builder /usr/local/bin /usr/local/bin
COPY --from=builder /usr/local/share/vim  /usr/local/share/vim

# install pip
ENV PACKAGES="\
    bash \
    git \
    ruby \
    ruby-dev \
    ruby-json \
    python2 \
    python3 \
    py-pip \
    nodejs \
    npm \
    libxt \
    libx11 \
"

RUN apk --update add $PACKAGES && \
    rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

# install supported vim8 and neovim
RUN install_vim -tag v7.4.052 -name vim7 -build \
                -tag v8.1.0519 -name vim8 -build \
                -tag neovim:v0.4.3 -name neovim -build

# set default vim install
RUN cp /vim-build/bin/vim8 /usr/local/bin/vim

# upgrade node and yarn
RUN npm install -g npm yarn

# copy vimrc 
ADD tests/vimrc /root/.vimrc

# install vint
RUN pip install typing>=4.6.2 pathlib==1.0.1 enum34>=1.0.4 vim-vint==0.3.19
