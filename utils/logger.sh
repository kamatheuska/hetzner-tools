#!/bin/bash

function logger() {
   local level="$1"
   shift
   local message="$*"
   local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
   
   case "$level" in
       "INFO")
           echo -e "[$timestamp] ℹ️  INFO: $message\n"
           ;;
       "WARN")
           echo -e "[$timestamp] ⚠️  WARN: $message\n"
           ;;
       "ERROR")
           echo -e "[$timestamp] ❌ ERROR: $message\n"
           ;;
       "SUCCESS")
           echo -e "[$timestamp] ✅ SUCCESS: $message\n"
           ;;
       "DEBUG")
           echo -e "[$timestamp] 🐛 DEBUG: $message\n"
           ;;
       *)
           echo -e "[$timestamp] 📝 LOG: $message\n"
           ;;
   esac
}
