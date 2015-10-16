[![Build Status](https://travis-ci.org/kjhealy/lintscreen.svg?branch=master)](https://travis-ci.org/kjhealy/lintscreen) 

# lintscreen: Using lintr and travis-ci to check the R code in `.Rmd` files

This repository contains a configuration file and a tiny shell script that allow you to check the R code in your Rmarkdown files for stylistic errors using [lintr](https://github.com/jimhester/lintr) and [Travis CI](https://travis-ci.org/). It takes advantage of the newer "containerized" infrastructure on Travis to make use of pre-built R binaries, and caches locally-built packages. The result is that, after the first build completes successfully in about ten minutes, subsequent runs will be much faster---usually around a minute or less.

## Motivation

The context is students submitting homework written in `RMarkdown` files. Like [Matt Salganik](https://msalganik.wordpress.com/2015/06/09/rapid-feedback-on-code-with-lintr/), I wanted to set up a system where students must make sure their R code passes the basic stylistic checks provided by [lintr](https://github.com/jimhester/lintr) before they submit it for grading. Students write `.Rnw` files containing discussion or notes together with chunks of R code, and we just want to check the code meets some minimal level of syntactical and stylistic correctness. This makes it easier to read and also to return to later.

The most recent version of R's `lintr` package can check `.Rmd` files natively. What we'd like is for this to happen automatically when we commit the file to our GitHub repository. 

[Travis CI](https://travis-ci.org/) is a service designed for much heavier lifting than we use here. It is meant for software developers who want to check their software as they go, making sure it compiles and passes various tests. In this case, it takes your repository, sets up an R environment from scratch on a linux machine somewhere, runs `lintr` on your `.Rmd` files, and then reports whether there are any problems. Doing this for small homework assignments would take an unreasonably long time if we were building our virtual machines from scratch, but Travis CI offers containerization and caching capabilities that make this much faster (after the initial setup). Right now this containerization means some aspects of the development environment are a little more restrictive than they would otherwise be, but this doesn't matter for our purposes because we just want to check code for some errors, and not really run anything very complicated.

## What to do

1. Let's say you have a GitHub account already. Clone this repository and then [get Travis CI set up](https://travis-ci.org/getting_started). Sign in to Travis with your GitHub account, then [follow the instructions](https://travis-ci.org/getting_started) to link the cloned github repository to Travis.
2. Add your own `.Rmd` file to the repository, or make a change to the `sample.Rmd` file. 
3. Push the change to GitHub.
4. This should make Travis-CI build a VM, install R, and run the little linter script. Go to the Travis-CI and you'll see the build running. to see the results. This will take about ten minutes the first time around. Once it's done, though, the R libraries will be cached and the next time you make a change and push it to Github, it will go much faster---less than a minute, most likely.

If you clone this repository, you can change the link at the top of this `README.md` so that it points to your build and not mine. [The instructions for how to do that are here](http://docs.travis-ci.com/user/status-images/).


## Alternatively

If you want to lint an `.Rmd` file or files at the top level of an existing repository, simply copy the `.travis.yml` configuration file and the `travis-linter.sh` script to that repo, activate that repo on Travis-CI, and then push a change to github. This will trigger a build on Travis as above.


## Acknowledgements

Thanks to Matt Salganik for the [original impetus](https://msalganik.wordpress.com/2015/06/09/rapid-feedback-on-code-with-lintr/) to do this, and the [initial scripts](https://github.com/soc504-s2015-princeton). Thanks to [Jan Tilly](http://jtilly.io/) for his [R travis container example](https://github.com/jtilly/R-travis-container-example), which incidentally can be used to build full-blown R packages, rather than simply the lint-checking I'm using it for here.
