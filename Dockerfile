FROM testbed/vim:latest

# install pip
ENV PACKAGES="\
    bash \
    git \
    python \
    py-pip \
    nodejs \
    npm \
"
RUN apk --update add $PACKAGES && \
    rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

#  install supported vim8 and neovim 
RUN install_vim -tag v7.4.052 -name vim7 -build \ 
                -tag v8.1.0519 -name vim8 -build \
                -tag neovim:v0.3.5 -name neovim -build 

# install vint
RUN pip install vim-vint==0.3.19
