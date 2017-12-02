#!/usr/bin/bash

fb_page=($(cat facebook_pages.txt))
current_date=($(cat current_date.txt))
for(( j=0; j<${#fb_page[@]}; j++))
do
    if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_dates.txt ]
    then
        if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_links.txt ]
        then
            if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_length.txt ]
            then
                if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_views.txt ]
                then


                    dates_count=($(grep -c "^" facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_dates.txt))
                    links_count=($(grep -c "^" facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_links.txt))
                    length_count=($(grep -c "^" facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_length.txt))
                    views_count=($(grep -c "^" facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_views.txt))

                    if [ ${dates_count} -eq ${links_count} ]
                    then
                        if [ ${dates_count} -eq ${length_count} ]
                        then
                            if [ ${dates_count} -eq ${views_count} ]
                            then
                                echo "========================"
                                echo "Successful dates/links/length/views ${j} parsing ${fb_page[j]}/${current_date} number of lines ${dates_count}"
                                echo "========================"
                                echo ""
                            else
                                echo "========================"
                                echo "Invalid views count ${j} ${fb_page[j]}/${current_date}, exiting script."
                                echo "========================"
                                echo ""
                                exit
                            fi
                        else
                            echo "========================"
                            echo "Invalid length count ${j} ${fb_page[j]}/${current_date}, exiting script."
                            echo "========================"
                            echo ""
                            exit
                        fi
                    else
                        echo "========================"
                        echo "Invalid links count ${j} ${fb_page[j]}/${current_date}, exiting script."
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
                echo "facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_length.txt not found , exiting script."
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
    else
        echo "========================"
        echo "facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_dates.txt not found , exiting script."
        echo "========================"
        echo ""
        exit
    fi

    video_names=($(ls facebook_sampling/${fb_page[j]}/${current_date}/downloaded_videos/))

    if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_res.txt ]
    then
        if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_size.txt ]
        then
            if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_fps.txt ]
            then
                res_count=($(grep -c "^" facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_res.txt))
                size_count=($(grep -c "^" facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_size.txt))
                fps_count=($(grep -c "^" facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_fps.txt))

                if [ ${res_count} -eq ${size_count} ]
                then
                    if [ ${res_count} -eq ${fps_count} ]
                    then
                        echo "========================"
                        echo "Successful res/size/fps ${j} parsing ${fb_page[j]}/${current_date} number of lines res ${res_count}"
                        echo "========================"
                        echo ""
                    else
                        echo "========================"
                        echo "Invalid fps count ${j} ${fb_page[j]}/${current_date}, exiting script."
                        echo "========================"
                        echo ""
                        exit
                    fi
                else
                    echo "========================"
                    echo "Invalid size count ${j} ${fb_page[j]}/${current_date}, exiting script."
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
done
