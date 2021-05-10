Doesn't create a tag that already exists.

  $ $TESTDIR/../bin/run -D -r freckle/faktory_worker_haskell -c abc123 -v 1.0.2.2
  Tag v1.0.2.2 exists in freckle/faktory_worker_haskell already

Would create a tag that doesn't yet exist.

  $ $TESTDIR/../bin/run -D -r freckle/faktory_worker_haskell -c abc123 -v 9.9.9.9
  Would create v9.9.9.9 => abc123 in freckle/faktory_worker_haskell

Reads package.yaml for version if not given.

  $ echo 'version: 1.0.2.2' > "$CRAMTMP"/package.yaml
  > $TESTDIR/../bin/run -D -r freckle/faktory_worker_haskell -c abc123 -y "$CRAMTMP"/package.yaml
  Tag v1.0.2.2 exists in freckle/faktory_worker_haskell already

Reads package.yaml regardless of whitespace, or comments

  $ echo 'version:  1.0.2.2   # foo' > "$CRAMTMP"/package.yaml
  > $TESTDIR/../bin/run -D -r freckle/faktory_worker_haskell -c abc123 -y "$CRAMTMP"/package.yaml
  Tag v1.0.2.2 exists in freckle/faktory_worker_haskell already
