#!/bin/bash
source $PWD/install.conf
function IF_ROOT()
{
   if [[ $EUID -ne 0 ]]; then
       echo "$MSG_IF_ROOT"
       exit 1
   fi
}
function BASE_PKG()
{
    for INSTALL_BASE_PKG in $@ ; do
        which $INSTALL_BASE_PKG >/dev/null || sudo apt-get install $INSTALL_BASE_PKG -y
    done
}

function PRE_INST()
{
   if [ -f $PATH_FILE ]; then
      read -p "$MSG_IF_IN " ANSWER
      case ${ANSWER:0:1} in
        y|Y )
          echo "$MSG_RUN_SC"
        ;;
         * )
          echo "$MSG_STOP"
          exit
        ;;
      esac
   else
      echo "$MSG_RUN"
   fi
}

function IF_FOLDER()
{
   if [ -z $1 ]; then
      echo "$MSG_BAD_ARG"
      exit 1
   else
      if [ ! -d $1 ]; then
         mkdir -p $1
      else
         echo "$MSG_DIR_EXT"
      fi
   fi
}

function IF_INST()
{ 
   if [ -z $1 ] || [ -z $2 ] || [ -z $3 ] || [ -z $4 ] ; then
      echo "$MSG_BAD_ARG"
      exit 1
   else 
      test -e $1 || echo "$2" ; cp -v -p $3 $4 
      chmod +x $1
   fi 
}

function POST_INST()
{
  if [ -f $1 ]; then
     echo $IF_FILE_EX
     ln -s -v -f $2 $3
  else
     echo $ERROR
  fi
}
BASE_PKG $PKG_BASE
IF_ROOT
PRE_INST
IF_FOLDER $INST_FOLDER
IF_INST $INST_FILE $IF_FILE_NE $INST_FILE $INST_FOLDER
POST_INST $PATH_FILE $PATH_FILE $INST_FOLDER/$CMD_START
