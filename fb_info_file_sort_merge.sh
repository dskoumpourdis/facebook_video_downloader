#!/usr/bin/bash

fb_page=($(cat facebook_pages.txt))
current_date=($(cat current_date.txt))

for(( j=0; j<${#fb_page[@]}; j++))
do        
    if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info_links_views_dates_length.txt ]
    then

        sort -k 4 facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info_links_views_dates_length.txt > facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info_links_views_dates_length_sorted.txt
        
    else
        echo "========================"
        echo "facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info_links_views_dates_length.txt not found , exiting script."
        echo "========================"
        echo ""
        exit
    fi

    if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info_length_res_fps_size.txt ]
    then

        sort -k 1 facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info_length_res_fps_size.txt > facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info_length_res_fps_size_sorted.txt
    
    else
        echo "========================"
        echo "facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info_length_res_fps_size.txt not found , exiting script."
        echo "========================"
        echo ""
        exit
    fi

    if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info_length_res_fps_size_sorted.txt ]
    then
        if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info_links_views_dates_length_sorted.txt ]
        then

            sed -i -r 's/\S+//1' facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info_length_res_fps_size_sorted.txt

            paste facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info_links_views_dates_length_sorted.txt facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info_length_res_fps_size_sorted.txt > facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info_final.txt
        
        else
            echo "========================"
            echo "facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info_links_views_dates_length_sorted.txt not found , exiting script."
            echo "========================"
            echo ""
            exit
        fi
    else
        echo "========================"
        echo "facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info_length_res_fps_size_sorted.txt not found , exiting script."
        echo "========================"
        echo ""
        exit
    fi

done    