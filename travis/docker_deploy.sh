#!/bin/bash

# MIT License
#
# Copyright (c) 2017 Maxime Wojtczak
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

set -ex

# Pull request are not supported as secrets are unavailable anyway
if [ "$TRAVIS_EVENT_TYPE" == "pull_request" ]
then
    exit 0
fi

# Assuming Github username = Docker username
export DOCKER_REPOSITORY=$TRAVIS_REPO_SLUG
export DOCKER_USERNAME=$(echo $DOCKER_REPOSITORY | sed 's#\/.*##')

# Add tags according to the current branch and tag
export DOCKER_TAGS=()
if [ -n "$TRAVIS_BRANCH" ]
then
    DOCKER_TAGS+=($(echo $TRAVIS_BRANCH | sed 's#\/#-#g'))
    if [ "$TRAVIS_BRANCH" == 'master' ]
    then
        DOCKER_TAGS+=('latest')
    fi
fi
if [ -n "$TRAVIS_TAG" ]
then
    DOCKER_TAGS+=($TRAVIS_TAG)
fi

# Process build
docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
docker build -t $DOCKER_REPOSITORY:$TRAVIS_COMMIT .
for tag in "${DOCKER_RELEASE_TAGS[@]}"
do
    docker tag $DOCKER_REPOSITORY:$TRAVIS_COMMIT $DOCKER_REPOSITORY:$tag
done
docker push $DOCKER_REPOSITORY
