#! /usr/bin/env bash
#----------
UNI_BUILD_ROOT=`pwd`
FF_TARGET=$1
set -e
set +x

FF_ACT_ARCHS_32="armv5 armv7a x86"
FF_ACT_ARCHS_64="armv5 armv7a arm64 x86 x86_64"
FF_ACT_ARCHS_ALL=$FF_ACT_ARCHS_64

echo_archs() {
    echo "===================="
    echo "[*] check archs"
    echo "===================="
    echo "FF_ALL_ARCHS = $FF_ACT_ARCHS_ALL"
    echo "FF_ACT_ARCHS = $*"
    echo ""
}

echo_usage() {
    echo "Usage:"
    echo "  compile-libmp3lame.sh armv5|armv7a|arm64|x86|x86_64"
    echo "  compile-libmp3lame.sh all|all32"
    echo "  compile-libmp3lame.sh all64"
    echo "  compile-libmp3lame.sh clean"
    echo "  compile-libmp3lame.sh check"
    exit 1
}

echo_nextstep_help() {
    #----------
    echo ""
    echo "--------------------"
    echo "[*] Finished"
    echo "--------------------"
    echo "# to continue to build ffmpeg, run script below,"
    echo "sh compile-ffmpeg.sh "
    echo "# to continue to build ijkplayer, run script below,"
    echo "sh compile-ijk.sh "
}

#----------
case "$FF_TARGET" in
    "")
        echo_archs armv7a
        sh tools/do-compile-libmp3lame.sh armv7a
    ;;
    armv5|armv7a|arm64|x86|x86_64)
        echo_archs $FF_TARGET
        sh tools/do-compile-libmp3lame.sh $FF_TARGET
        echo_nextstep_help
    ;;
    all32)
        echo_archs $FF_ACT_ARCHS_32
        for ARCH in $FF_ACT_ARCHS_32
        do
            sh tools/do-compile-libmp3lame.sh $ARCH
        done
        echo_nextstep_help
    ;;
    all|all64)
        echo_archs $FF_ACT_ARCHS_64
        for ARCH in $FF_ACT_ARCHS_64
        do
            sh tools/do-compile-libmp3lame.sh $ARCH
        done
        echo_nextstep_help
    ;;
    clean)
        echo_archs FF_ACT_ARCHS_64
        rm -rf ./build/libmp3lame-*
        for ARCH in $FF_ACT_ARCHS_ALL
        do
            if [ -d libmp3lame-$ARCH ]; then
                cd libmp3lame-$ARCH && rm config.h && cd -
            fi
        done
    ;;
    check)
        echo_archs FF_ACT_ARCHS_ALL
    ;;
    *)
        echo_usage
        exit 1
    ;;
esac
