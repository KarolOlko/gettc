# Purpose

Download a [TopCoder](http://topcoder.com/tc) problem, parse the examples and system tests, then finally generate a basic template for C++, Haskell, and Java. You write the function definition and the generated template will take care of running it against input and output files.

TopCoder is a heaven for programmers. Solving algorithmic problems is a great way to embrace the passion for programming. There are problems for all levels. A strong academic background is not required to enjoy it. If you like Project Euler, you will probably love TopCoder.

However, you normally have to paste the solution into TopCoder's online arena where it will be checked for correctness. This tool gives you another choice: check your solution completely offline.

# Prerequisites

The following packages are hard dependencies. They are required no matter what language you plan to use gettc for.

1. [Ruby](http://www.ruby-lang.org/en/downloads/): The [Ruby installer](http://rubyinstaller.org/) is recommend for Windows users. 
2. [RubyGems](http://rubygems.org/pages/download): Many Ruby installations already bundle RubyGems.
3. The standard GCC toolset: Most Unix systems have it bundled. Windows users may use [MinGW](http://www.mingw.org).

# Installation 

Suppse gettc has been downloaded and unpacked to ~/download/gettc:

    $ cd ~/download/gettc
    $ rake gem
    $ sudo gem i pkg/gettc-1.0.0.gem

# Get started

Now try running it for the first time:

    $ cd ~/download
    $ gettc 11290

11290 is the problem ID for [this problem in TopCoder](http://www.topcoder.com/stat?c=problem_statement&pm=11290&rd=14537) (login is required). The ID is encoded in the URL. If gettc has been installed correctly, the previous command should output:

     You have given ID = 11290
     Downloading problem to raw HTML ... Done
     Parsing problem from raw HTML ... Done
     Generating problem diectory for PickAndDelete ... Done

Now a directory called PickAndDelete was generated with the following content:
    
    PickAndDelete
    `-- bin
        `-- runner.sh
    `-- data
        `-- demo
            `-- 0.in
            `-- 0.out
            `-- 1.in
            `-- 1.out
            ...
        `-- sys
            `-- 0.in
            `-- 0.out
            `-- 1.in
            `-- 1.out
            ...
    `-- prob
        `-- prob.html
        `-- prob.md
    `-- solve
        `-- cpp
            `-- Makefile
            `-- PickAndDelete.cpp
            `-- PickAndDeleteRunner.cpp
            `-- PickAndDeleteTest.cpp
        `-- haskell
            `-- Makefile
            `-- PickAndDelete.hs
            `-- PickAndDeleteRunner.hs
            `-- PickAndDeleteTest.hs
        `-- java
            `-- build.xml
            `-- PickAndDelete.java
            `-- PickAndDeleteRunner.java
            `-- PickAndDeleteTest.java
    `-- util
        `-- check
            `-- check.cpp
            `-- Makefile

Don't be put down by the number of generated files. You'll only need to touch the PickAndDelete.*X* file, where *X* is your language of choice. And it's possible to tweak the template so that less files are generated next time.

# Usage

## For C++

### Requirements

C++ users don't need to do anything extra.

### Try out

    $ cd PickAndDelete/solve/cpp
    $ make 

The output will look something like:

    Check 0 ... Time: 0.01s - Memory: 2036K
    Failed
    Input: <["1 2"]>
    Expected: <3>
    Received: <0>
    Check 1 ... Time: 0.00s - Memory: 2044K
    Failed
    Input: <["2 2 2 2 2 2 2 2 2"]>
    Expected: <512>
    Received: <0>
    Check 2 ... Time: 0.00s - Memory: 2048K
    Failed
    Input: <["5", " 1 ", "2"]>
    Expected: <34>
    Received: <0>
    Check 3 ... Time: 0.00s - Memory: 2060K
    Failed
    Input: <["3 ", "14159 265", "3589 7", " 932"]>
    Expected: <353127147>
    Received: <0>
    4 cases checked, 4 failed
    Failed cases: 0 1 2 3

The default action of *make* is to run against the examples given in problem statement. In order to challange system tests, type:

    $ make sys

The output should be:

    57 cases checked, 57 failed
    Failed cases: 0 1 10 11 12 13 14 15 16 17 18 19 2 20 21 22 23 24 25 26 27 28 29 3 30 31 32 33 34 35 36 37 38 39 4 40 41 42 43 44 45 46 47 48 49 5 50 51 52 53 54 55 56 6 7 8 9

### Unit test

The [Boost](http://www.boost.org/) library is required if you wish to apply TDD:

    $ make test

If you don't write tests, there is no need to install Boost.

## For Haskell

### Requirements

[Cabal](http://www.haskell.org/cabal/download.html) is required. But it could have been bundled by your Haskell installer. Now:

    $ sudo cabal update
    $ sudo cabal install parsec

### Try out

Refer to the C++ section. It's exactly the same.

### Unit test

HUnit is required if you wish to apply TDD:

    $ sudo cabal install HUnit

If you don't write tests, there is no need to install HUnit.

## For Java

### Requirements

[Apache Ant](http://ant.apache.org/) is required. This should come as no surprise to most Java programmers.

### Try out

It's like C++, except that you use *ant* instead of *make*. So:

    $ ant

Will run against the examples. And:

    $ ant sys

Will run against the system tests.

### Unit test

[JUnit](https://github.com/KentBeck/junit/downloads) is required. Don't use the beta versions. Download one of the stable jar archives and put the jar into Ant's lib dir. 

If you don't write unit tests, just ignore this section.

# FAQ

## I only use Java

    $ cd ~/.gettc/template/solve
    $ rm -rf haskell cpp

If you want them back, copy from the project's Gem directory.

## I want to see input/output for the failed cases in system tests

    $ make sysv

## I never write unit tests

    $ cd ~/.gettc/template/solve/
    $ rm {cpp,haskell,java}/*Test.*

## The output of make is too verbose
    
Use *make --quiet* instead. Here is what I do in my bashrc:

    alias mk=`make --quiet`

## But I use C&#35;

You may email me to request support for your favourite language. I don't promise it will get delivered, but I'll see what I can do. 

I would appreciate if you roll your own, too. First refer to gettc/plugins to see what I did for the supported languages. There are a few things you need to do:

1. Write a generic parser that parses the generated input files into variables.
2. Write an engine in Ruby that acts a helper to generate code.
3. Write the template files in ERuby.

As what happens in gettc's generator is:

1. It will automatically require ~/.gettc/include/*/engine.rb.
2. It will walk through ~/.gettc/template, read each file as an ERuby template, and copy to the target directory.

Once you have done the hard work, please make a fork or something for other people to use.

## Wrong username or password when trying to download

You should provide your own username/password in ~/.gettc/config.yml

# Tips

1. You may `rm -rf build` after you're done solving to save some disk space.

# Known Issues

## Ambiguous function names

Sometimes the solution method has the same name with a standard library function, such as *filter*. In this case, you'll have to manually change the function name to something else in the runner and solution files.

## String parsing error

TopCoder allows a string to be like: "This is" one string", while gettc gets confused with the quote character in between. If your solution fails only under this situation, it's probably correct.
