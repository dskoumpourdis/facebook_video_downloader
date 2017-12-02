#!/usr/bin/bash

fb_page=($(cat facebook_pages.txt))
current_date=($(cat current_date.txt))

for(( j=0; j<${#fb_page[@]}; j++))
do
    if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_links.txt ]
    then
        if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_views.txt ]
        then
            if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_dates.txt ]
            then
                if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_length.txt ]
                then
                
                    paste facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_links.txt facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_views.txt facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_dates.txt facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_length.txt | pr -t -e20 > facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/temp.txt
                    tr -s " " < facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/temp.txt > facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/temp2.txt
                    tr ' ' '\t' < facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/temp2.txt > facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info_links_views_dates_length.txt
                    # tr '\t MB' ' MB' < facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/temp2.txt > facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/temp3.txt
                    # tr '\t kB' ' kB' < facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/temp3.txt > facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info_links_views_dates_length.txt

                else
                    echo "========================"
                    echo "facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_length.txt not found , exiting script."
                    echo "========================"
                    echo ""
                    exit
                fi
            else
                echo "========================"
                echo "facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_dates.txt not found , exiting script."
                echo "========================"
                echo ""
                exit
            fi
        else
            echo "========================"
            echo "facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_views.txt not found , exiting script."
            echo "========================"
            echo ""
            exit
        fi
    else
        echo "========================"
        echo "facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_links.txt not found , exiting script."
        echo "========================"
        echo ""
        exit
    fi

    echo "========================"
    echo "facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info_links_views_dates_length.txt created successfully."
    echo "========================"
    echo ""

if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/temp.txt ]
then
    if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/temp2.txt ]
    then
        rm facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/temp.txt
        rm facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/temp2.txt
    fi
fi

done

