Gettc's Haskell plugin to generate Haskell solutions for TopCoder problems.

## User requirements

Besides GHC, [Cabal](http://www.haskell.org/cabal/download.html) is required.
But it could have been bundled by your Haskell installer. Now:

    $ [sudo] cabal update
    $ [sudo] cabal install parsec

## Developement status

* `rake test:haskell` Passed
* `rake test:engine` Passed
* `rake generate` OK
* `rake run` OK

## Change log

### gettc-1.6

* Delete the unit test file in template.
