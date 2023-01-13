# Project Catalyst Github Action for supplying Rust and related tools to speed up CI builds

Custom GH Action to speed up and simplify building in CI that requires tools to be built during the CI process.

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

## Inputs

## `tool-cmd`

**Required** when `entrypoint` not customized.

This command is run verbatim, inside the container, at the root of the checked-out repository along with any arguments following it.

If the `entrypoint` is modified, this only contains the arguments to that `entrypoint` and is not required.

## `entrypoint`

**Optional** Over-ride the default entry point.

## Outputs

None, other than build artefacts from the executed command.

## Example usage

### Build mdbook docs and fail on linkcheck

NOTE: *Requires the cargo make command of the project to have a 'build-docs-linkcheck' rule*

```yaml
uses:  input-output-hk/catalyst-standards@v0.6
with:
  tool-cmd: cargo make build-docs-linkcheck
```

### Use a custom entry point from the repo

NOTE: *Requires the repo to have the 'my_entrypoint.sh' in its root.*

```yaml
uses:  input-output-hk/catalyst-standards@v0.6
with:
  entrypoint: './my_entrypoint.sh'
  tool-cmd: parameters to my entrypoint would go here
```

## How it works

The `./tools_container` subdirectory contains a `Docker` file which builds a container containing all the tools we wish to have available for this action.

This container is automatically built by github CI using `.github/workflows/build_publish_tools_container.yml` when:

* Push with no tag AND `./tools_container` has been modified:
  * Image is called `input-output-hk/catalyst-standards:main`
* Release created with tag format `v??` where `??` is anything.
  * Image is called `input-output-hk/catalyst-standards:v??`
  * Latest Image is updated in `input-output-hk/catalyst-standards:latest`

The `./Dockerfile` is then used by the action when run by the consuming CI.  It creates a NEW temporary container and customizes that container's entry point.

### Optional usage

Instead of using this GitHub action, the 'input-output-hk/catalyst-standards` tools container can be used directly in CI.

Example:

```yaml
runs:
  using: 'docker'
  image: 'input-output-hk/catalyst-standards:v0.5'
  args:
    - 'bzz'
  pre-entrypoint: 'setup.sh'
  entrypoint: 'main.sh'
```
