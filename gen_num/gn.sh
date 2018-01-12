#!/bin/bash
#It will be difficult for you to understand what is happening here
LEN_RANGE="10"
MSG_IF_STRING="You can only use numeric values!"
MSG_ARG="Missing argument"
MSG_FP="OUT\n-------------------------\n"
MSG_TP="\n-------------------------"
ERROR="Script execution failed"
PARAM_VALUE="F"

function PARS_NUM()
{
    if [[ "$1" == *[A-Za-z]* ]]; then
        echo $MSG_IF_STRING
        exit 1
    fi
}

function ST_OUT()
{
    RANGE=`strings /dev/urandom | grep -o "[A-Z a-z 1-9]" | head -$1 | xargs echo | sed s/' '//g`
    RANGE_MSG="$MSG_FP$RANGE$MSG_TP"
    if [ -z $1 ]; then
        echo $MSG_ARG
        exit 1
    else
        if [ -z $2 ]; then
            echo -e $RANGE_MSG
            elif [ ! -z $2 ]; then
            echo $RANGE
        else

            echo $ERROR
        fi
    fi
}
function GEN_RANGE()
{
    
    if [ ! -z $1 ] || [ ! -z $2 ]; then
        if [[ "$2" == "F" ]]; then
            ST_OUT $1
            elif [[ "$2" == "T" ]]; then
            ST_OUT $1 $2
        else
            echo $ERROR
        fi
    else
        echo $ERROR
        exit 1
    fi
}
while [ -n "$1" ]
do
    case "$1" in
        -l) PARAM_VALUE="T" ;;
        *) LEN_RANGE=$1 ; PARAM_VALUE="F" ;;
    esac
    shift
done

PARS_NUM $LEN_RANGE
GEN_RANGE $LEN_RANGE $PARAM_VALUE
