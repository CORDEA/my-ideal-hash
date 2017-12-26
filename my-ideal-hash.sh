#!/bin/bash
# encoding:utf-8
#
# Copyright 2017 Yoshihiro Tanaka
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#
# Author: Yoshihiro Tanaka <contact@cordea.jp>
# date  : 2017-12-25

expected=$1

diff=`git diff --staged --name-only`
if [ -n "$diff" ]; then
    echo "Some files are not commited."
    exit 1
fi

echo "Searching..."

index=0
while :
do
    faketime -f "+${index}s" git commit --amend --allow-empty --no-edit > /dev/null
    hash=`git log -1 --pretty=format:%H`
    if [[ $hash == *"$1"* ]]; then
        echo "Completed!"
        echo $hash
        break
    fi
    index=$((++index))
done
