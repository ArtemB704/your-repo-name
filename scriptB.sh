#!/bin/bash

send_request() {
    while true; do
        curl -s http://localhost > /dev/null
        sleep $((RANDOM % 6 + 5))
    done
}

for i in {1..10}; do
    send_request &
done

wait
