# Haskell Tag Action

Creates a tag for the current version of a Haskell project, if it doesn't
already exist. Presumably, creation of this tag should trigger more automation,
such as [uploading to Hackage][stack-upload-action].

[stack-upload-action]: https://github.com/freckle/stack-upload-action

**NOTE**: If your project includes version bumps together in the PRs where the
features or fixes happen, you _may_ not want to use this.

## Usage

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      # build, test, validate...

      # When landing in main, grab the current version out of package.yaml and,
      # if one doesn't already exist, push a tag named "v${version}".
      - if: ${{ github.ref == 'refs/heads/main' }}
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        uses: freckle/haskell-tag
```

## Inputs

- `package-yaml`: Path to the `package.yaml` file to read version from. Default
  is `./package.yaml`.

- `tag-prefix`: Prefix to apply to version string when using as a tag. Default
  is `v`. A package with version `1.2.3.4` will be tagged `v1.2.3.4`.

## Motivation & Alternatives

When we release Haskell packages to Hackage, the steps are always the same:

1. Open a PR with version bump and CHANGELOG for review or visibility
2. Merge that change
3. Push a tag for that version
4. Automation sees the tag and uploads to Hackage

(3) is a bit tedious and surprisingly error-prone.

Often, projects will automate this by using [Semantic Commits][]. As changes
land in `main`, commit message conventions determine how large of a version bump
to make, and then automation creates an appropriate release at that version.

[semantic commits]:
  https://gist.github.com/joshbuchea/6f47e86d2510bce28f8e7f42ae84c716

This just doesn't work for us. Instead, we want to control versions and releases
more collaboratively, via step (1) above. This Action represents our current
compromise.

## Caveats

To simplify this Action we do the following:

1. Expect `package.yaml` and do not support reading `*.cabal` directly
1. Read `version: ` naively (`sed`)

PRs are welcome to address any of the above, include rewriting in a Real
Language :tm:.

---

[LICENSE](./LICENSE)
