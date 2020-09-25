#!/usr/bin/env bash

OS=${1}
GITHUB_WORKSPACE=${2}

export BOOST_TEST_LOG_LEVEL=all

if [[ ${OS} == "windows" ]]; then
    echo "----------------------------------------"
    echo "Checking binary security for ${OS}"
    echo "----------------------------------------"
    make -C src check-security
    make -C src check-symbols
elif [[ ${OS} == "osx" ]]; then
    echo "----------------------------------------"
    echo "No binary checks available for ${OS}"
    echo "----------------------------------------"
elif [[ ${OS} == "linux" || ${OS} == "linux-disable-wallet" ]]; then
    echo "----------------------------------------"
    echo "Checking binary security for ${OS}"
    echo "----------------------------------------"
    make -C src check-security
    echo "----------------------------------------"
    echo "Running unit tests for ${OS}"
    echo "----------------------------------------"
    make check
    echo "----------------------------------------"
    echo "Running functional tests for ${OS}"
    echo "----------------------------------------"
    ${GITHUB_WORKSPACE}/src/test/test_raven
elif [[ ${OS} == "arm32v7" || ${OS} == "arm32v7-disable-wallet" ]]; then
    echo "----------------------------------------"
    echo "No binary checks available for ${OS}"
    echo "----------------------------------------"
else
    echo "You must pass an OS."
    echo "Usage: ${0} <operating system> <github workspace path>"
    exit 1
fi

