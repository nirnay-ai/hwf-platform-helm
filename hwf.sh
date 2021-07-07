#!/bin/bash

printAny(){
    echo "Hello " $1
}

case "$1" in
   "init") echo "Initializing applications"
   printAny init
   ;;
   "banana") echo "I like banana nut bread."
   ;;
   "kiwi") echo "New Zealand is famous for kiwi."
   ;;
esac
