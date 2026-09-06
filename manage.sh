#!/usr/bin/env bash

set -Eeuo pipefail

readonly LOCAL_IMAGE="gtgwf"
readonly GHCR_OWNER="renatormc"
readonly IMAGE="ghcr.io/renatormc/gtgwf"
readonly TAG="${TAG:-latest}"

usage() {
    printf 'Uso: %s {build|push}\n' "$0"
    printf '\nVariavel opcional:\n'
    printf '  TAG         Tag da imagem (padrao: latest)\n'
}

image_name() {
    printf '%s\n' "$IMAGE"
}

build() {
    local local_tag="${LOCAL_IMAGE}:${TAG}"
    docker build --tag "$local_tag" .

    docker tag "$local_tag" "$(image_name):${TAG}"
}

push() {
    local local_tag="${LOCAL_IMAGE}:${TAG}"
    local remote_tag="$(image_name):${TAG}"

    docker image inspect "$local_tag" >/dev/null 2>&1 || {
        printf 'A imagem local nao existe. Execute "%s build" primeiro.\n' "$0" >&2
        exit 1
    }

    docker tag "$local_tag" "$remote_tag"
    docker push "$remote_tag"
}

case "${1:-}" in
    build)
        build
        ;;
    push)
        push
        ;;
    -h|--help)
        usage
        ;;
    *)
        usage >&2
        exit 1
        ;;
esac
