#!/bin/bash
docker events --filter event=start --filter event=die --format '{{json .}}' |
while read -r line; do
    status=$(echo "$line" | jq -r '.status // .Action')
    name=$(echo "$line" | jq -r '.Actor.Attributes.name')

    if [[ "$status" == "start" ]]; then
        notify-send -a "Docker" "  Container Started" "Container: $name" -u low
    elif [[ "$status" == "die" ]]; then
        exit_code=$(echo "$line" | jq -r '.Actor.Attributes.exitCode')

        if [[ "$exit_code" == "0" ]]; then
            notify-send -a "Docker" "  Container Stopped" "$name exited gracefully" -u normal
        else
            notify-send -a "Docker" -u critical "  Container Crashed" "$name (exit code: $exit_code)"
        fi
    fi
done

