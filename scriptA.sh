#!/bin/bash

check_usage() {
    docker stats --no-stream --format "{{.Name}}:{{.CPUPerc}}" |
    grep "$1" | awk -F: '{print $2}' | sed 's/%//'
}

launch_container() {
    docker run -d --name $1 --cpus=$2 http_server_image
}

stop_container() {
    docker stop $1 && docker rm $1
}

monitor_containers() {
    while true; do
        srv1_usage=$(check_usage srv1)

        if (( $(echo "$srv1_usage > 80.0" | bc -l) )); then
            echo "srv1 overloaded, starting srv2"
            launch_container srv2 1
        fi

        srv2_usage=$(check_usage srv2)

        if (( $(echo "$srv2_usage > 80.0" | bc -l) )); then
            echo "srv2 overloaded, starting srv3"
            launch_container srv3 1
        fi

        srv3_usage=$(check_usage srv3)

        if (( $(echo "$srv3_usage < 10.0" | bc -l) )); then
            echo "srv3 idle, stopping"
            stop_container srv3
        fi

        sleep 120
    done
}

monitor_containers
