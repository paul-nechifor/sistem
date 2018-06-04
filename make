#!/usr/bin/env bash

set -e

root=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

main() {
    make_build_image
    build_vim
}

make_build_image() {
    cd "$root"/builder/build-image
    docker build -t build-image .
}

build_vim() {
    local args=(
        run
        --rm
        -it
        -v "$root/dist:/home/p/.sistem/dist"
        -v "$root/builder:/builder"
        build-image
        /builder/compile/vim
    )
    docker "${args[@]}"
}

main "$@"
