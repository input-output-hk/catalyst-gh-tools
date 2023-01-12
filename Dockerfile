# Container image that runs your code
FROM rust:1.66.1-slim

# Version numbers for all the crates we're going to install
ARG MDBOOK_VERSION="0.4.25"
ARG MDBOOK_LINKCHECK_VERSION="0.7.7"

ARG MDBOOK_TOC_VERSION="0.7.0"
ARG MDBOOK_OPEN_ON_GH_VERSION="2.3.1"
ARG MDBOOK_KROKI_VERSION="0.1.2"
ARG MDBOOK_REGEX_VERSION="0.0.2"
ARG MDBOOK_ADMONISH_VERSION="1.8.0"
ARG MDBOOK_TOC_VERSION="0.11.0"

ENV CARGO_INSTALL_ROOT /usr/local/
ENV CARGO_TARGET_DIR /tmp/target/

RUN apt-get update && \
    apt-get install -y libssl-dev pkg-config ca-certificates build-essential make perl gcc libc6-dev

RUN cargo install mdbook --vers ${MDBOOK_VERSION} --verbose
RUN cargo install mdbook-linkcheck --vers ${MDBOOK_LINKCHECK_VERSION} --verbose
RUN cargo install mdbook-kroki-preprocessor --vers ${MDBOOK_KROKI_VERSION} --verbose
RUN cargo install mdbook-toc --vers ${MDBOOK_TOC_VERSION} --verbose
RUN cargo install mdbook-open-on-gh --vers ${MDBOOK_OPEN_ON_GH_VERSION} --verbose
RUN cargo install mdbook-regex --vers ${MDBOOK_REGEX_VERSION} --verbose
RUN cargo install mdbook-admonish --vers ${MDBOOK_ADMONISH_VERSION} --verbose

# Create the final image
FROM ubuntu:20.04

LABEL maintainer="steven.johnson@iohk.io"
ENV RUST_LOG info

# used when serving
EXPOSE 3000

COPY --from=build /usr/local/bin/mdbook* /bin/

# Make sure we have certs
RUN apt-get update && apt-get install --no-install-recommends -y ca-certificates && rm -rf /var/cache/apt/lists


ENTRYPOINT [ "/bin/mdbook" ]