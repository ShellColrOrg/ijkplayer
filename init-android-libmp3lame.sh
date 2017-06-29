#! /usr/bin/env bash

IJK_LIBMP3LAME_UPSTREAM=https://github.com/yangmu/libmp3lame.git
IJK_LIBMP3LAME_FORK=https://github.com/yangmu/libmp3lame.git
IJK_LIBMP3LAME_COMMIT=master
IJK_LIBMP3LAME_LOCAL_REPO=extra/libmp3lame

set -e
TOOLS=tools

echo "== pull libmp3lame base =="
sh $TOOLS/pull-repo-base.sh $IJK_LIBMP3LAME_UPSTREAM $IJK_LIBMP3LAME_LOCAL_REPO

function pull_fork()
{
    echo "== pull libmp3lame fork $1 =="
    sh $TOOLS/pull-repo-ref.sh $IJK_LIBMP3LAME_FORK android/contrib/libmp3lame-$1 ${IJK_LIBMP3LAME_LOCAL_REPO}
    cd android/contrib/libmp3lame-$1
    git checkout ${IJK_LIBMP3LAME_COMMIT} -B ijkplayer
    cd -
}

pull_fork "armv5"
pull_fork "armv7a"
pull_fork "arm64"
pull_fork "x86"
pull_fork "x86_64"
