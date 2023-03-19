#!/usr/bin/env bash

function main {
    set -eu

    echo "steps:"

    for D in .. ../*/; do
        case "$D" in
            */all/)
                true
                ;;
            *)
                if test -d "$D/.buildkite"; then
                    echo "- command: \"cat $D/.buildkite/pipeline.yml | sed 's#command: .#command: \\\"cd $D; #' | buildkite-agent pipeline upload\""
                fi
                ;;
        esac
    done
}

main "$@"