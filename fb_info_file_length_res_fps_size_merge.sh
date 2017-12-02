#!/usr/bin/bash

fb_page=($(cat facebook_pages.txt))
current_date=($(cat current_date.txt))

for(( j=0; j<${#fb_page[@]}; j++))
do        
    if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_sort_length.txt ]
    then
        if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_res.txt ]
        then
            if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_fps.txt ]
            then
                if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_size.txt ]
                then

                    paste facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_sort_length.txt facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_res.txt facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_fps.txt facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_size.txt | pr -t -e20 > facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/temp.txt
                    tr -s " " < facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/temp.txt > facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/temp2.txt
                    tr ' ' '\t' < facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/temp2.txt > facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info_length_res_fps_size.txt
                    # tr '\t MB' ' MB' < facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/temp2.txt > facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/temp3.txt
                    # tr '\t kB' ' kB' < facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/temp3.txt > facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info_final.txt

                else
                    echo "========================"
                    echo "facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_size.txt not found , exiting script."
                    echo "========================"
                    echo ""
                    exit
                fi
            else
                echo "========================"
                echo "facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_fps.txt not found , exiting script."
                echo "========================"
                echo ""
                exit
            fi
        else
            echo "========================"
            echo "facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_res.txt not found , exiting script."
            echo "========================"
            echo ""
            exit
        fi
    else
        echo "========================"
        echo "facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_sort_length.txt not found , exiting script."
        echo "========================"
        echo ""
        exit
    fi

    echo "========================"
    echo "facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info_length_res_fps_size.txt created successfully."
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

