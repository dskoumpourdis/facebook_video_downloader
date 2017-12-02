#!/usr/bin/bash

fb_page=($(cat facebook_pages.txt))
current_date=($(cat current_date.txt))

for(( j=0; j<${#fb_page[@]}; j++))
do
    if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_cdn_links.json ]
    then
        if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_dates.txt ]
        then
            echo "========================"
            echo "Cleaning facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_dates.txt."
            echo "========================"
            echo ""
            rm facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_dates.txt
        fi

            echo "========================"
            echo "Creating facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_dates.txt."
            echo "========================"
            echo ""

            dates=($(grep -Po '"created_time":.*?,' facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_cdn_links.json | grep -Po '([0-9]*-[0-9]*-[0-9]*)'))

            for(( i=0; i<${#dates[@]}; i++))
            do
                echo ${dates[i]} >> facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_dates.txt;
            done
            echo "# ${j}"
            echo "========================"
            echo "Dates successfully parsed."
            echo "========================"
            echo ""
    else
        echo "========================"
        echo "facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_cdn_links.json not found , exiting script."
        echo "========================"
        echo ""
        exit
    fi
done