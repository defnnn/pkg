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
                    echo "  - command: \"cd $D && nix build && if test -x validate; then nix develop --command ./validate; fi\""
                fi
                ;;
        esac
    done
}

main "$@"