#!/usr/bin/bash

fb_page=($(cat facebook_pages.txt))
current_date=($(cat current_date.txt))

for(( j=0; j<${#fb_page[@]}; j++))
do
    if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info.json ]
    then
        if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info.json ]
        then
            if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_links.txt ]
            then
                if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_ids.txt ]
                then
                    echo "========================"
                    echo "Cleaning facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_ids.txt."
                    echo "========================"
                    echo ""
                    rm facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_ids.txt
                fi
                echo "========================"
                echo "Cleaning facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_links.txt."
                echo "========================"
                echo ""
                rm facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_links.txt
            fi
                echo "# ${j}"
                echo "========================"
                echo "Creating facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_links.txt."
                echo "Creating facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_ids.txt."
                echo "========================"
                echo ""

                links=($(grep -Po '"permalink_url":.*?,' facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info.json | cut -d'"' -f 4))
                ids=($(grep -Po '"id":.*?,' facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info.json | cut -d'"' -f 4))

                for(( i=0; i<${#links[@]}; i++))
                do
                    echo "https://www.facebook.com${links[i]}" >> facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_links.txt;
                    echo "${ids[i]}" >> facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_ids.txt;
                done
        else
            echo "========================"
            echo "facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info.json not found , exiting script."
            echo "========================"
            echo ""
            exit
        fi
    else
        echo "========================"
        echo "facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info.json not found , exiting script."
        echo "========================"
        echo ""
        exit
    fi
done
