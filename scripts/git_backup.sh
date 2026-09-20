#!/bin/sh
export PATH=/opt/bin:/opt/sbin:/usr/bin:/bin:$PATH
export HOME=/usr/data

cd /usr/data/printer_data/config || exit 1

git -c safe.directory=/usr/data/printer_data/config add .
git -c safe.directory=/usr/data/printer_data/config commit -m "Klipper backup $(date +'%Y-%m-%d %H:%M:%S')"

if git -c safe.directory=/usr/data/printer_data/config push origin main; then
    echo "Backup successfully pushed to GitHub!"
else
    echo "No changes to push or an error occurred while pushing."
    exit 1
fi
