#!/usr/bin/env bash

set -Eeuo pipefail

readonly GHCR_OWNER="renatormc"
readonly PACKAGE="gtgwf"
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
    docker build --tag "$(image_name):${TAG}" .
}

push() {
    local remote_tag="$(image_name):${TAG}"

    docker image inspect "$remote_tag" >/dev/null 2>&1 || {
        printf 'A imagem nao existe localmente. Execute "%s build" primeiro.\n' "$0" >&2
        exit 1
    }

    docker push "$remote_tag"

    if ! command -v gh >/dev/null 2>&1; then
        printf 'O push foi concluido, mas nao foi possivel tornar o pacote publico: instale o GitHub CLI (gh).\n' >&2
        exit 1
    fi

    gh api --method PATCH \
        "/user/packages/container/${PACKAGE}" \
        --field visibility=public >/dev/null
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
