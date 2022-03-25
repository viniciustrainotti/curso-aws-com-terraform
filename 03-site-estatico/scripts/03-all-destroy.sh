#!/bin/sh

set -e

cd "${0%/*}" || return

echo "Destroy everything? (Y/N)"
read CHOICE

if [ "$CHOICE" = "Y" ]; then
    echo "----------------------------------------"
    echo "Starting destroy application ..."
    cd ../terraform || return
    terraform destroy -auto-approve
    echo "Starting destroy application ..."
    cd ../bucket-remote-state || return
    terraform destroy -auto-approve
    echo "----------------------------------------"
else
    echo "finishing ..."
    exit 1
fi


