#!/usr/bin/bash

fb_page=($(cat facebook_pages.txt))
current_date=($(cat current_date.txt))

for(( j=0; j<${#fb_page[@]}; j++))
do
    if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info.json ]
    then
        echo "# ${j}"
        echo "========================"
        echo "Cleaning facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info.json."
        echo "========================"
        echo ""
        sed -i 's/[\]//g' facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info.json
    else
        echo "========================"
        echo "facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info.json not found , exiting script."
        echo "========================"
        echo ""
        exit
    fi

    # if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_cdn_links.json ]
    # then
    #     echo "# ${j}"
    #     echo "========================"
    #     echo "Cleaning facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_cdn_links.json."
    #     echo "========================"
    #     echo ""
    #     sed -i 's/[\]//g' facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_cdn_links.json
    # else
    #     echo "========================"
    #     echo "facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_cdn_links.json not found , exiting script."
    #     echo "========================"
    #     echo ""
    #     exit
    # fi
done