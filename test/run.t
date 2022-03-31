Doesn't create a tag that already exists.

  $ $TESTDIR/../bin/run -D -r freckle/faktory_worker_haskell -c abc123 -t v1.0.2.2
  Tag v1.0.2.2 exists in freckle/faktory_worker_haskell already

Would create a tag that doesn't yet exist.

  $ $TESTDIR/../bin/run -D -r freckle/faktory_worker_haskell -c abc123 -t v9.9.9.9
  Would create v9.9.9.9 => abc123 in freckle/faktory_worker_haskell
