#!/bin/bash
who -b | awk '{ print $3" "$4}'
