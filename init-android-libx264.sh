#! /usr/bin/env bash

IJK_LIBX264_UPSTREAM=http://git.videolan.org/git/x264.git
IJK_LIBX264_FORK=http://git.videolan.org/git/x264.git
IJK_LIBX264_COMMIT=master
IJK_LIBX264_LOCAL_REPO=extra/libx264

set -e
TOOLS=tools

echo "== pull libx264 base =="
sh $TOOLS/pull-repo-base.sh $IJK_LIBX264_UPSTREAM $IJK_LIBX264_LOCAL_REPO

function pull_fork()
{
    echo "== pull libx264 fork $1 =="
    sh $TOOLS/pull-repo-ref.sh $IJK_LIBX264_FORK android/contrib/libx264-$1 ${IJK_LIBX264_LOCAL_REPO}
    cd android/contrib/libx264-$1
    git checkout ${IJK_LIBX264_COMMIT} -B ijkplayer
    cd -
}

pull_fork "armv5"
pull_fork "armv7a"
pull_fork "arm64"
pull_fork "x86"
pull_fork "x86_64"
