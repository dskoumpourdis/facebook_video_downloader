#!/usr/bin/bash

fb_page=($(cat facebook_pages.txt))
current_date=($(date +'%Y-%m-%d'))
date +'%Y-%m-%d' > current_date.txt

if [ ! -d facebook_sampling ]
then
    echo "========================"
    echo "Creating facebook_sampling"
    echo "========================"
    echo ""
    mkdir facebook_sampling
fi


for(( i=0; i<${#fb_page[@]}; i++))
do
    if [ ! -d facebook_sampling/${fb_page[$i]} ]
    then
        echo "# ${i}"
        echo "========================"
        echo "Creating facebook_sampling/${fb_page[$i]}"
        echo "========================"
        echo ""
        mkdir facebook_sampling/${fb_page[$i]}
    fi

    if [ ! -d facebook_sampling/${fb_page[$i]}/${current_date} ]
    then
        echo "# ${i}"
        echo "========================"
        echo "Creating facebook_sampling/${fb_page[$i]}/${current_date}"
        echo "========================"
        echo ""
        mkdir facebook_sampling/${fb_page[$i]}/${current_date}
    fi

    if [ ! -d facebook_sampling/${fb_page[$i]}/${current_date}/fb_video_info ]
    then
        echo "# ${i}"
        echo "========================"
        echo "Creating facebook_sampling/${fb_page[$i]}/${current_date}/fb_video_info"
        echo "========================"
        echo ""
        mkdir facebook_sampling/${fb_page[$i]}/${current_date}/fb_video_info
    fi

    if [ ! -d facebook_sampling/${fb_page[$i]}/${current_date}/downloaded_videos ]
    then
        echo "# ${i}"
        echo "========================"
        echo "Creating facebook_sampling/${fb_page[$i]}/${current_date}/downloaded_videos"
        echo "========================"
        echo ""
        mkdir facebook_sampling/${fb_page[$i]}/${current_date}/downloaded_videos
    fi
done
