#!/usr/bin/bash
fb_page=($(cat facebook_pages.txt))
current_date=($(cat current_date.txt))


for(( j=0; j<${#fb_page[@]}; j++))
do
	video_names=($(ls facebook_sampling/${fb_page[j]}/${current_date}/downloaded_videos/))

	if [ ${#video_names[@]} -ne 0 ]
	then

		echo "Videos in folder : ${#video_names[@]}"
		echo ""

		if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_res.txt ]
		then
			echo "========================"
			echo "Removing old facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_res.txt."
			echo "========================"
			echo ""
			rm facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_res.txt
		fi

		if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_fps.txt ]
		then
			echo "========================"
			echo "Removing old facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_fps.txt."
			echo "========================"
			echo ""
			rm facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_fps.txt
		fi

		if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_size.txt ]
		then
			echo "========================"
			echo "Removing old facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_size.txt."
			echo "========================"
			echo ""
			rm facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_size.txt
		fi

		if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_sort_length.txt ]
		then
			echo "========================"
			echo "Removing old facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_sort_length.txt."
			echo "========================"
			echo ""
			rm facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_sort_length.txt
		fi

		echo "========================"
		echo "Parsing video resolution."
		echo "========================"
		echo ""

		for (( i=0; i<${#video_names[@]}; i++ ))
		do
			exiftool facebook_sampling/${fb_page[j]}/${current_date}/downloaded_videos/${video_names[$i]} | grep -o "[0-9]\{3,\}x[0-9]\{3,\}" >> facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_res.txt
		done

		echo "========================"
		echo "Parsing video fps."
		echo "========================"
		echo ""

		for (( i=0; i<${#video_names[@]}; i++ ))
		do
			exiftool facebook_sampling/${fb_page[j]}/${current_date}/downloaded_videos/${video_names[$i]} | grep "Video Frame Rate" | grep -Po "([0-9]*\.[0-9]*)|([0-9]*)" >> facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_fps.txt
		done

		echo "========================"
		echo "Parsing video size."
		echo "========================"
		echo ""

		for (( i=0; i<${#video_names[@]}; i++ ))
		do
			exiftool -filesize facebook_sampling/${fb_page[j]}/${current_date}/downloaded_videos/${video_names[$i]} | grep -Po "(([0-9]*\.[0-9]*)|([0-9]*)) (MB|kB)" >> facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_size.txt
		done

		echo "========================"
		echo "Parsing video length."
		echo "========================"
		echo ""

		for (( i=0; i<${#video_names[@]}; i++ ))
		do
			ffprobe -i facebook_sampling/${fb_page[j]}/${current_date}/downloaded_videos/${video_names[$i]} -show_entries format=duration -v quiet -of csv="p=0" >> facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_sort_length.txt
		done

		if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_fps.txt ]
		then
			if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_res.txt ]
			then
				if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_size.txt ]
				then
					if [ -f facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_sort_length.txt ]
					then
						fps_num=($(cat facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_fps.txt))
						res_num=($(cat facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_res.txt))
						size_num=($(cat facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_size.txt))
						sort_length_num=($(cat facebook_sampling/${fb_page[j]}/${current_date}/fb_video_info/fb_video_sort_length.txt))
				
					else
						echo "========================"
						echo "Info files not found."
						echo "========================"
						echo ""
						exit
					fi
				fi
			fi
		fi
		
		if [ ${#video_names[@]} -eq ${#fps_num[@]} ]
		then
			if [ ${#video_names[@]} -eq ${#res_num[@]} ]
			then
				if [ ${#video_names[@]} -eq ${#sort_length_num[@]} ]
				then
					echo "# ${j}"
					echo "========================"
					echo "Resolution fps length and size parsing has been successful."
					echo "========================"
					echo ""
				else
					echo "========================"
					echo "Invalid length count."
					echo "========================"
					echo ""
				fi				
			else
				echo "========================"
				echo "Invalid resolution count."
				echo "========================"
				echo ""
			fi
		else
			echo "========================"
			echo "Invalid fps count."
			echo "========================"
			echo ""
		fi
	else
		echo "========================"
		echo "No videos found in folder facebook_sampling/${fb_page[j]}/${current_date}/downloaded_videos/."
		echo "========================"
		exit
		echo ""
	fi
done