#! /bin/bash

# Written by Rob B.
# This script will, after installation of vpnc, perform various functions required to run the software

script=$(basename "$0")

if [[ $EUID -ne 0 ]]; then
  echo "$script must be run as root" 1>&2
  exit 1
fi

function checkpid {
  pidfile="/tmp/vpnc.pid"
  pidno=`pidof vpnc`
  if [[ $pidno != "" ]] || [ -f $pidfile ]; then
    printf '\e[1;33m%-6s\e[m\n' "vpnc appears to be running.  Process hung or PID file missing?  Try $script restart option if this occurs."
  exit 1
  fi
}

function removepid {
  pidfile="/tmp/vpnc.pid"
      if [ -f $pidfile ]; then
        rm $pidfile
      fi
}

function stop {
  vpndisconnect=`which vpnc-disconnect`
  $vpndisconnect 
  removepid
}

function start {
  checkpid
  vpnscript=`which vpnc`
  $vpnscript --debug 3
  pidno=`pidof vpnc`
  echo $pidno > $pidfile
  printf '\e[1;34m%-6s\e[m\n' "vpnc PID file written to /tmp"
}

function status {
  pidfile="/tmp/vpnc.pid"
  pidno=`pidof vpnc`
  if [[ $pidno != "" ]] && [ -f $pidfile ]; then
    printf '\e[1;34m%-6s\e[m\n' "vpnc appears to be running: PID file is $pidfile; PID number is $pidno"
  else
    printf '\e[1;31m%-6s\e[m\n' "PID file is missing or process is not running"
  fi
}
  
case "$1" in

    stop) 
      stop
    ;;

    start) 
        start
    ;;

    restart)
      stop
      sleep 1
      start
    ;;

    status)
      status
    ;; 
    
    *) 
      echo "Usage: $0 {stop|start|restart|status}"
      exit 1

esac
