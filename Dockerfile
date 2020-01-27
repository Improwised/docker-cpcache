FROM elixir:1.9.4

RUN cd $HOME && \
    git clone https://github.com/nroi/cpcache.git && \
    cd cpcache/cpcache && \
    mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get && \
    mv ../../cpcache /var/lib && \
    mix compile

RUN useradd -r -s /bin/bash -m -d $HOME/cpcache cpcache && \
    mkdir -p /var/cache/cpcache/state && \
    mkdir /etc/cpcache && \
    mkdir -p /var/cache/cpcache/pkg/community/os/x86_64 && \
    mkdir -p /var/cache/cpcache/pkg/community-staging/os/x86_64 && \
    mkdir -p /var/cache/cpcache/pkg/community-testing/os/x86_64 && \
    mkdir -p /var/cache/cpcache/pkg/core/os/x86_64 && \
    mkdir -p /var/cache/cpcache/pkg/extra/os/x86_64 && \
    mkdir -p /var/cache/cpcache/pkg/gnome-unstable/os/x86_64 && \
    mkdir -p /var/cache/cpcache/pkg/kde-unstable/os/x86_64 && \
    mkdir -p /var/cache/cpcache/pkg/multilib/os/x86_64 && \
    mkdir -p /var/cache/cpcache/pkg/multilib-testing/os/x86_64 && \
    mkdir -p /var/cache/cpcache/pkg/staging/os/x86_64 && \
    mkdir -p /var/cache/cpcache/pkg/testing/os/x86_64 && \
    chown -R cpcache:cpcache "/var/cache/cpcache"

WORKDIR /var/lib/cpcache/cpcache

RUN cp conf/cpcache.toml /etc/cpcache/

EXPOSE 7070

ENV MIX_ENV=prod

ENTRYPOINT iex -S mix