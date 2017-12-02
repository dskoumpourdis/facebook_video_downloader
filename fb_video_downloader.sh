#!/usr/bin/bash

fb_page=($(cat facebook_pages.txt))
current_date=($(cat current_date.txt))
#${#fb_page[@]}
for(( j=0; j<${#fb_page[@]}; j++))
do
    if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_info.json ]
    then
        echo "========================"
        echo "Video downloading starting."
        echo "========================"
        echo ""

        links=($(grep -Po '"source":.*?}' facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_videoinfo.json | cut -d'"' -f 4))
        echo " videos in page ${#links[@]}"
        # ${#links[@]}
        for(( i=0; i<${#links[@]}; i++))
        do
            youtube-dl --sleep-interval 2 -o "facebook_sampling/${fb_page[j]}/${current_date}/downloaded_videos/%(id)s.%(ext)s" ${links[i]};
            
            #echo ${i} ${links[i]}
            #echo ""
        done

        video_count=($(ls facebook_sampling/${fb_page[j]}/${current_date}/downloaded_videos | wc -l))

        if [ $video_count -eq ${#links[@]} ]
        then
            echo "# ${j}"
            echo "========================"
            echo "Videos downloaded successfully."
            echo "========================"
            echo ""
        else
            echo "========================"
            echo "Invalid video count , check for errors."
            echo "========================"
            echo ""
        fi

    else
        echo "========================"
        echo "facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_videoinfo.json not found , exiting script."
        echo "========================"
        echo ""
        exit
    fi
done