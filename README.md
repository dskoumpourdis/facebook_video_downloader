# facebook_video_downloader
A collection of javascript, bash and php scripts able to download videos and their statistics from facebook.

Prerequisites: Facebook PHP SDK, Phantomjs, youtube-dl, exiftool, ffprobe

Project files and hierarchy

fb_info_parser_top.sh

  fb_video_folder_creator.sh

  fb_video_info_downloader.sh

  fb_video_json_cleaner.sh

  fb_video_links_id_parser.sh

  fb_video_cdn_link_updater.sh

  fb_video_json_cdn_cleaner.sh

  fb_video_views_parser.sh

  fb_video_dates_parser.sh

  fb_video_length_parser.sh

fb_video_downloader_top.sh

    fb_video_cdn_downloader.sh

    fb_video_fps_resolution_size_length_parser.sh

fb_sort_merge_top.sh

    fb_info_file_length_res_fps_size_merge.sh

    fb_info_file_links_views_dates_length_merge.sh

    fb_info_file_sort_merge.sh

fb_test_top.sh

This project was created to enable a user to download videos and their info from certain video publishers on facebook.
There are 4 major scripts and 14 sub-scripts. This kind of hierarchy was selected in an effort to divide the functionality into seperate scripts.


Major Script 1. fb_info_parser_top.sh, subscripts 9

fb_video_folder_creator.sh

    Creates a file with the current date and the nested folders required using the names of the facebook pages.

fb_video_info_downloader.sh

    Invokes the facebook PHP API using the app id and your personal app secret key. A new access token is required
    each time the app is used as they have a rather short period of expiration. This script returns the id and the permalink_url     of the 24 most recently posted videos from each page in the facebook_pages.txt file in a json file named and situated as 	     needed.

fb_video_json_cleaner.sh

    Cleans the output of the previous script of any special characters.

fb_video_links_id_parser.sh

    Creates the files fb_video_links.txt and fb_video_ids.txt which contain the links and the ids of the videos respectively.

fb_video_cdn_link_updater.sh

    Invokes the facebook PHP API and parses each video of each page to return the time created, length, permalink_url and the new source cdn link which has an expiry date.

fb_video_json_cdn_cleaner.sh

    Cleans the output of the previous script of any special characters.

fb_video_views_parser.sh

    Parses the video links and renders them by using phantomjs and fb_video_link_renderer.js to get the views of each video.

fb_video_dates_parser.sh

	Parses the created_time attribute of the videos from the fb_video_cdn_links.json file

fb_video_length_parser.sh

	Parses the length attribute of the videos from the fb_video_cdn_links.json file


Major Script 2. fb_video_downloader_top.sh, subscripts 2

fb_video_cdn_downloader.sh

	Invokes youtube-dl to download the videos while naming them appropriately.

fb_video_fps_resolution_size_length_parser.sh

	Invokes exiftool and ffprobe to parse the fps, resoluton, file size and length of the videos.


Major Script 3. fb_sort_merge_top.sh, subscripts 3

fb_info_file_length_res_fps_size_merge.sh

	Merges the fps, resoluton, file size and length of the videos into one file.

fb_info_file_links_views_dates_length_merge.sh

	Merges the links, views, dates and length of the videos into one file.

fb_info_file_sort_merge.sh

	Sorts the info files using the common columns and then merges them into one file. 


Major Script 3. fb_test_top.sh, subscripts 0

	Checks for any errors during the parsing and info collection stage.
