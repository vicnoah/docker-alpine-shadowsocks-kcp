#!/bin/sh
 
(nohup ./ssserver.sh >/dev/null 2>&1) & 
(nohup ./kcptun.sh >/dev/null 2>&1) &
