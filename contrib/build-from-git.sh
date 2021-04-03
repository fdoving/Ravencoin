#!/bin/bash
# Script is made for ubuntu, might work on debian and alike.
# USAGE: ./build-from-git.sh <platform>
# where platform is one of: windows, osx, linux, arm32v7
# make sure we have git
apt update
apt install git


# checkout git, modify to your own usage.
git clone https://github.com/fdoving/Ravencoin.git
cd Ravencoin
git checkout fdov-update-depends

# install depends from apt.
.github/00-install-deps.sh $1


# build or copy depends
.github/02-copy-build-dependencies.sh $1

# setup environment
.github/03-export-path.sh $1 `pwd`

# autogen
./autogen.sh

# configure build
.github/04-configure-build.sh $1 `pwd`

# build
make -j21
