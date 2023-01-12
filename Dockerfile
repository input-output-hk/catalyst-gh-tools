# Container image that runs your code
FROM ghcr.io/input-output-hk/catalyst-gh-mdbook-doc:main

LABEL maintainer="steven.johnson@iohk.io"
ENV RUST_LOG info

# used when serving
EXPOSE 3000

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
