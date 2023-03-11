#!/bin/bash

set -ex

cd v8

VERSION=$1

if echo ${VERSION} | grep 'trunk'; then
	VERSION="trunk-$(date +%Y%m%d)"
	BRANCH="main"
else
	BRANCH="branch-heads/${VERSION}"
fi

echo "Branch identified: ${BRANCH}"

FULLNAME="d8-${VERSION}.tar.xz"
OUTPUT="$2/${FULLNAME}"

git fetch
git checkout $BRANCH

if echo ${VERSION} | grep 'trunk'; then
	git pull
fi

GIT_REVISION=$(git rev-parse HEAD)
REVISION="d8-${GIT_REVISION}"
LAST_REVISION="${3}"

echo "ce-build-revision:${REVISION}"
echo "ce-build-output:${OUTPUT}"

if [[ "${REVISION}" == "${LAST_REVISION}" ]]; then
	echo "ce-build:SKIPPED"
	exit
fi

PREFIX="$(pwd)/out/x64.release"
echo "PREFIX: ${PREFIX}"

python ./tools/dev/gm.py x64.release

tar Jcf ${OUTPUT} --transform "s,^./,./d8-${VERSION}/," -C ${PREFIX} .

echo "ce-build-status:OK"
