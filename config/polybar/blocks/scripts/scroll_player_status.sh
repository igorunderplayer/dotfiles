#!/bin/bash

rscroll -c --command-delay 1000 "$(dirname $0)/get_player_status.sh" &

wait
