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

export CODACY_COVERAGE_REPORTER_VERSION=2.0.0

wget https://oss.sonatype.org/service/local/repositories/releases/content/com/codacy/codacy-coverage-reporter/$CODACY_COVERAGE_REPORTER_VERSION/codacy-coverage-reporter-$CODACY_COVERAGE_REPORTER_VERSION-assembly.jar

java -cp codacy-coverage-reporter-$CODACY_COVERAGE_REPORTER_VERSION-assembly.jar com.codacy.CodacyCoverageReporter -l Java -r target/site/jacoco/jacoco.xml
