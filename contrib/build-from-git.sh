#!/bin/bash
# Script is made for ubuntu, might work on debian and alike.
# USAGE: ./build-from-git.sh <platform>
# where platform is one of: windows, osx, linux, arm32v7

WORKPRE=/build-$1
GITDIR=Ravencoin
WORKDIR=$WORKPRE/$GITDIR/
rm -rf $WORKPRE
mkdir $WORKPRE

# make sure we have git
apt update
apt install git

# checkout git, modify to your own usage.
cd $WORKPRE
git clone https://github.com/fdoving/Ravencoin.git
cd $GITDIR
git checkout fdov-update-depends

# install depends from apt.
$WORKDIR/.github/scripts/00-install-deps.sh $1

# build or copy depends
$WORKDIR/.github/scripts/02-copy-build-dependencies.sh $1 $WORKDIR

# setup environment
$WORKDIR/.github/scripts/03-export-path.sh $1 $WORKDIR

# autogen
$WORKDIR/autogen.sh

# configure build
$WORKDIR/.github/scripts/04-configure-build.sh $1 $WORKDIR

# build
make -j22
