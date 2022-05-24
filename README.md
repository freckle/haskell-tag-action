# Haskell Tag Action

Creates a tag for the current version of a Haskell project, if it doesn't
already exist. Presumably, creation of this tag should trigger more automation,
such as [uploading to Hackage][stack-upload-action].

[stack-upload-action]: https://github.com/freckle/stack-upload-action

## Usage

```yaml
- uses: freckle/haskell-tag-action@v1
```

If a tag is created, it'll be found in `outputs.tag`.

## Examples

### Publishing a Hackage Package

```yaml
jobs:
  tag:
    runs-on: ubuntu-latest
    steps:
      - id: tag
        uses: freckle/haskell-tag-action@v1
    outputs:
      tag: ${{ steps.tag.outputs.tag }}

  release:
    needs: [tag]
    if: needs.tag.outputs.tag
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: freckle/stack-upload-action@v1
        env:
          HACKAGE_API_KEY: ${{ secrets.HACKAGE_UPLOAD_API_KEY }}
```

### GitHub Release with Executables attached

```yaml
jobs:
  tag:
    runs-on: ubuntu-latest
    steps:
      - id: tag
        uses: freckle/haskell-tag-action@v1
    outputs:
      tag: ${{ steps.tag.outputs.tag }}

  create-release:
    needs: [tag]
    if: needs.tag.outputs.tag
    runs-on: ubuntu-latest
    steps:
      - uses: actions/create-release@v1
        id: create-release
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          tag_name: ${{ needs.tag.outputs.tag }}
          # Additional options...
    outputs:
      upload_url: ${{ steps.create-release.outputs.upload_url }}

  upload-assets:
    needs: create-release
    runs-on: ${{ matrix.os }}
    steps:
      # Build executables...
      - uses: actions/upload-release-asset@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          upload_url: ${{ needs.create-release.outputs.upload_url }}
          # Additional options...
```

## Inputs

See [`action.yml`](./action.yml) for details.

## Motivation & Alternatives

When we release Haskell packages to Hackage, the steps are always the same:

1. Open a PR with version bump and CHANGELOG for review or visibility
2. Merge that change
3. Push a tag for that version
4. Automation sees the tag and uploads to Hackage

(3) is a bit tedious and surprisingly error-prone.

Often, projects will automate this by using [Semantic Commits][sc]. As changes
land in `main`, commit message conventions determine how large of a version bump
to make, and then automation creates an appropriate release at that version.

[sc]: https://gist.github.com/joshbuchea/6f47e86d2510bce28f8e7f42ae84c716

This just doesn't work for us. Instead, we want to control versions and releases
more collaboratively, via step (1) above. This Action represents our current
compromise.

## Caveats

To simplify this Action, we expect `package.yaml` and do not support reading
`*.cabal` directly.

PRs welcome (Including rewriting in a Real Language :tm:).

---

[LICENSE](./LICENSE)
