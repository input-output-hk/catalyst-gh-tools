# Container image that runs your code
FROM ghcr.io/input-output-hk/catalyst-gh-mdbook-doc:main

LABEL maintainer="steven.johnson@iohk.io"
ENV RUST_LOG info

# used when serving
EXPOSE 3000

ENTRYPOINT [ "/bin/mdbook" ]