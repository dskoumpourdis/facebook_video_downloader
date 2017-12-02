#!/usr/bin/bash

DIR_1="facebook_sampling/"

#DIR_2="fb_video_info"

if [ "$(ls -A $DIR_1)" ]
then
    echo "========================"
    echo "Cleaning $DIR_1"
    echo "========================"
    echo ""
    rm -r $DIR_1/*
else
    echo "========================"
    echo "Nothing to clean in $DIR_1"
    echo "========================"
    echo ""
fi

# if [ "$(ls -A $DIR_2)" ]
# then
#     echo "========================"
#     echo "Cleaning $DIR_2"
#     echo "========================"
#     echo ""
#     rm -r $DIR_2/*
# else
#     echo "========================"
#     echo "Nothing to clean in $DIR_2"
#     echo "========================"
#     echo ""
# fi



    # echo "========================"
    # echo "Parsing video views."
    # echo "========================"
    # echo ""