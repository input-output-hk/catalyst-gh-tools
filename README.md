# Project Catalyst Tools Container for supplying Rust and related tools to speed up CI builds

Container to speed up and simplify building in CI that requires tools to be built during the CI process.

## Tools Provided

* rust
* cargo
* cargo-make
* mdbook
  * mdbook-linkcheck
  * mdbook-kroki-preprocessor
  * mdbook-toc
  * mdbook-open-on-gh
  * mdbook-regex
  * mdbook-admonish

## Example usage

### Build mdbook docs and fail on linkcheck

NOTE: *Requires the cargo make command of the project to have a 'build-docs-linkcheck' rule*

```yaml
runs:
  using: 'docker'
  image: 'input-output-hk/catalyst-standards:v0.8'
  entrypoint: 'cargo'
  args:
    - 'make'
    - 'build-docs-linkcheck'
```

## How it works

The `./tools_container` subdirectory contains a `Docker` file which builds a container containing all the tools we wish to have available for this action.

This container is automatically built by github CI using `.github/workflows/build_publish_tools_container.yml` when:

* Push with no tag AND `./tools_container` has been modified:
  * Image is called `input-output-hk/catalyst-standards:main`
* Release created with tag format `v??` where `??` is anything.
  * Image is called `input-output-hk/catalyst-standards:v??`
  * Latest Image is updated in `input-output-hk/catalyst-standards:latest`

The `./Dockerfile` is then used by CI to quickly provide all the tools we might need.

### Recommendation

The specific version of the container should always be specified so that updates do not break builds unexpectedly.
