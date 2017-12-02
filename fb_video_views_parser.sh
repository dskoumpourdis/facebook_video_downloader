#!/usr/bin/bash

fb_page=($(cat facebook_pages.txt))
current_date=($(cat current_date.txt))

for(( j=0; j<${#fb_page[@]}; j++))
do
    if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_links.txt ]
    then
        echo "========================"
        echo "Parsing facebook_sampling/${fb_page[j]}/${current_date} video views."
        echo "========================"
        echo ""

        if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_views.txt ]
        then
            echo "========================"
            echo "Removing old facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_views.txt."
            echo "========================"
            echo ""
            rm facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_views.txt
        fi

        links=($(cat facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_links.txt))

        for(( i=0; i<${#links[@]}; i++))
        do
            result=($(phantomjs fb_video_link_renderer.js ${links[i]} | grep -Po '([0-9],?)* Views' | grep -Po '([0-9],?)*'))
            if [ ${#result[@]} -eq 1 ]
            then
                #echo "${result}"
                #echo "found"
                echo "${result}" >> facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_views.txt
            else
                #echo "${result}"
                #echo "not found"
                echo "" >> facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_views.txt
            fi

       
        #     phantomjs fb_video_link_renderer.js ${links[i]} > facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/html_dump.html
        #     grep -Po '([0-9],?)* Views' facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/html_dump.html | grep -Po '([0-9],?)*' >> facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_views.txt
        done

        # if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/html_dump.html ]
        # then
        #     echo "========================"
        #     echo "Removing old html_dump.html."
        #     echo "========================"
        #     echo ""
        #     rm facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/html_dump.html
        # fi

        # views=($(cat facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_views.txt))

        # if [ ${#links[@]} -eq ${#views[@]} ]
        # then
            non_unique_entries=$(uniq -dc facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_views.txt)
            if [ -n  "$non_unique_entries" ]
            then
                echo "# ${j}"
                echo "========================"
                echo "Views parsed successfully, but ${non_unique_entries} was repeated , check parsing for errors."
                echo "========================"
                echo ""
            else
                echo "# ${j}"
                echo "========================"
                echo "Views parsed successfully."
                echo "========================"
                echo ""
            fi
        # else
        #     echo "========================"
        #     echo "Views unsuccessfully parsed."
        #     echo "========================"
        #     echo ""
        #     exit
        # fi

    else
        echo "========================"
        echo "facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_links.txt not found , exiting script."
        echo "========================"
        echo ""
        exit
    fi
done