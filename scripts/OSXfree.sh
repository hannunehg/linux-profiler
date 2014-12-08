#!/bin/bash
FREE=$(vm_stat | grep "Pages free" | awk '{ print $3 }' | sed '$s/.$//')
ACTIVE=$(vm_stat | grep "Pages active" | awk '{ print $3 }' | sed '$s/.$//')
INACTIVE=$(vm_stat | grep "Pages inactive" | awk '{ print $3 }' | sed '$s/.$//')
SPECULATIVE=$(vm_stat | grep "Pages speculative" | awk '{ print $3 }' | sed '$s/.$//')
WIRED=$(vm_stat | grep "Pages wired" | awk '{ print $4 }' | sed '$s/.$//')
let TOTAL=$FREE+$ACTIVE+$INACTIVE+$SPECULATIVE+$WIRED
echo $TOTAL
echo $FREE
echo $ACTIVE
echo $INACTIVE
echo $SPECULATIVE
echo $WIRED

