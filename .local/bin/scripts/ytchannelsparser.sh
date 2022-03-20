#!/bin/bash
# ------------------------------------------

#csvcut -n /home/mdlima/Downloads/yt_test.csv | cut -c6-

# using [ expression ] syntax
if [ -f "/home/mdlima/.config/yt-channels/ytchannels.txt" ]; 
then

# if file exist then use csvcut to grab the channel name and link
# then removes first line
# then replaces commas with dashes
# then numbers the lines
# finally it replaces all the spaces in the beginning of each line
csvcut -c 1,5 /home/mdlima/Downloads/yt_test.csv | tail -n +2 | sed 's/,/ - /g' | nl -w2 -s' - ' | sed 's/^[ \t]*//' > /home/mdlima/.config/yt-channels/ytchannels.txt
else

# is it is not exist then use csvcut to grab the channel name and link
touch /home/mdlima/.config/zsh/yt-channels/ytchannels.txt
csvcut -c 1,5 /home/mdlima/Downloads/yt_test.csv | tail -n +2 | sed 's/,/ - /g' | nl -w2 -s' - ' | sed 's/^[ \t]*//'  > /home/mdlima/.config/zsh/yt-channels/ytchannels.txt
fi

