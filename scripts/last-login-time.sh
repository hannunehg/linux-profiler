#!/bin/bash
last | awk '(NR == 1){ print $4" "$5" "$6" "$7}'
