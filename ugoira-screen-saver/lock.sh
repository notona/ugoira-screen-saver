#!/usr/bin/env bash

set -eu

# Array with urls
illust_ids=(
"44326750" #ぽかぽかですとろい！
"44304107" #第六駆逐隊
"44302137" #ほのえり実験アニメ
)

# Seed random generator
RANDOM=$$$(date +%s)

# Get random url
illust_id=${illust_ids[$RANDOM % ${#illust_ids[@]} ]}

if [ $# -eq 1 ]; then
        if [ $1 == "-r" ]; then
                python3 ~/Library/Screen\ Savers/ugoira-screen-saver.saver/Contents/Resources/ugoira_downloader.py "$illust_id" > /dev/null
        fi
fi

if [ $# -eq 2 ]; then
        if [ $1 == "-a" ]; then
                python3 ~/Library/Screen\ Savers/ugoira-screen-saver.saver/Contents/Resources/ugoira_downloader.py "$2" > /dev/null
        fi
fi

open -a /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app
