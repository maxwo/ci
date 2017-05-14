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

# Retrieve release informations
export PROJECT_NAME=$(echo $TRAVIS_REPO_SLUG | sed 's#.*\/##')
export PROJECT_RELEASE=$TRAVIS_TAG
export FILENAME="$PROJECT_NAME-$PROJECT_RELEASE.tar.gz"

# Temporary file
export TEMPORARY_FILE=$(mktemp)

# Package the whole repo in a tar.gz to prepare release
tar czvf $TEMPORARY_FILE ./ --exclude='.[^/]*' --transform "s#^..#ci/#" --show-transformed-names

# Move file to current dir
mv $TEMPORARY_FILE $FILENAME
