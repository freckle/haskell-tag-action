# Haskell Tag Action

GitHub Action to create a tag for the version of a Haskell project, if it
doesn't already exist.

Presumably, creation of this tag should trigger more automation, such as
uploading to Hackage.

## Usage

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      # build, test, validate

      - if: ${{ github.ref == 'refs/heads/main' }}
        uses: freckle/haskell-tag
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
```

## Inputs

- `github-token`:

- `package-yaml`:

- `tag-prefix`:

---

[LICENSE](./LICENSE)
