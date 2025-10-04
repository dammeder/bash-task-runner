#!/bin/bash

set -euo pipefail ## if anything in the script fails => exit 

REMOTE_USER="root"
REMOTE_IP="68.183.145.114"
STEPS=()


while [[ $# -gt 0 ]]; do ## define arguments
    case "$1" in 
        --runs-on)
            VM=$2
            shift 2
        ;;
        --step)
            STEPS+=("$2")
            shift 2
        ;;
        *)
            echo "Usage: action --runs-on USER@HOST --step \"command_or_script\" [--step ...]"
            echo "  --runs-on  : Remote host to run commands on (user@ip)"
            echo "  --step     : Command or local script to execute"
            echo "¯\_(ツ)_/¯"
            exit 1
        ;;

    esac
done

for step in "${STEPS[@]}"; do 

    if [[ -f "$step" ]]; then ## if its a file, find it 
        FILE=$step
        echo "Located your file ╾━╤デ╦︻ (•_- )"
    elif [[ -f "./$step" ]]; then
        FILE=$step
        echo "Located your file ╾━╤デ╦︻ (•_- )"
    elif [[ -f "../$step" ]]; then
        FILE=$step
        echo "Located your file ╾━╤デ╦︻ (•_- )"
    else 
        FILE=""
    fi

    if [[ -n "$FILE" ]]; then ## copy the file to VM and run the script 
        echo "Connecting to VM"
        scp $FILE $VM:/tmp
        ssh $VM "chmod +x /tmp/$(basename $FILE)"
        echo "RUNNING SCRIPT..."
        ssh -t $VM "bash /tmp/$(basename $FILE)"
        ssh $VM "rm -r /tmp/$(basename $FILE)"
        echo ""
        echo "TELEPORTATION COMPLETE ᕙ( •̀ ᗜ •́ )ᕗ"
    else                    ## excecute the command in VM 
        echo "Connecting to VM"
        echo "Running the command: $step"
        ssh $VM "$step"
        echo ""
        echo "COMMAND EXCECUTION COMPLETE ᕙ( •̀ ᗜ •́ )ᕗ"
    fi
    echo ""
done
