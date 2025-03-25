#!/bin/bash
action="$1"
username="$2"
case $action in
    "add")
        useradd "$username"
        ;;
    "modify")
        usermod -s /bin/bash "$username"
        ;;
    "delete")
        userdel "$username"
        ;;
    *)
        echo "Usage: $0 {add|modify|delete} username"
        exit 1
        ;;
esac