# Container image that runs your code
FROM rust:1.66.1-slim as build

LABEL maintainer="steven.johnson@iohk.io"
ENV RUST_LOG info

# used when serving mdbook
EXPOSE 3000

# Version numbers for all the crates we're going to install
ARG CARGO_MAKE_VERSION="0.36.4"
ARG MDBOOK_VERSION="0.4.25"
ARG MDBOOK_LINKCHECK_VERSION="0.7.7"

ARG MDBOOK_OPEN_ON_GH_VERSION="2.3.1"
ARG MDBOOK_KROKI_VERSION="0.1.2"
ARG MDBOOK_REGEX_VERSION="0.0.2"
ARG MDBOOK_ADMONISH_VERSION="1.8.0"
ARG MDBOOK_TOC_VERSION="0.11.0"
ARG MDBOOK_FS_SUMMARY_VERSION="0.2.1"
ARG CARGO_SPELLCHECK_VERSION="0.12.3"

ENV CARGO_INSTALL_ROOT /usr/local/
ENV CARGO_TARGET_DIR /tmp/target/

RUN apt-get update && \
    apt-get install -y \
        libssl-dev \
        pkg-config \
        ca-certificates \
        build-essential \
        make \
        perl \
        gcc \
        protobuf-compiler \
        clang \
        llvm-dev \
        libclang-dev \
        nodejs \
        postgresql-client \
        libpq-dev \
        libc6-dev && \
    rm -rf /var/cache/apt/lists

RUN cargo install cargo-spellcheck --vers ${CARGO_SPELLCHECK_VERSION} --verbose
RUN cargo install cargo-make --vers ${CARGO_MAKE_VERSION} --verbose
RUN cargo install mdbook --vers ${MDBOOK_VERSION} --verbose
RUN cargo install mdbook-linkcheck --vers ${MDBOOK_LINKCHECK_VERSION} --verbose
RUN cargo install mdbook-kroki-preprocessor --vers ${MDBOOK_KROKI_VERSION} --verbose
RUN cargo install mdbook-toc --vers ${MDBOOK_TOC_VERSION} --verbose
RUN cargo install mdbook-open-on-gh --vers ${MDBOOK_OPEN_ON_GH_VERSION} --verbose
RUN cargo install mdbook-regex --vers ${MDBOOK_REGEX_VERSION} --verbose
RUN cargo install mdbook-admonish --vers ${MDBOOK_ADMONISH_VERSION} --verbose
RUN cargo install mdbook-fs-summary --vers ${MDBOOK_FS_SUMMARY_VERSION} --verbose

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

