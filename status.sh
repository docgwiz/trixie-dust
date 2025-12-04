# status bar config file for sway

# get date
#date_formatted=$(date "+%a %Y-%m-%d %H:%M")
day_formatted=$(date "+%a")
date_formatted=$(date "+%d-%b-%Y") 
time_formatted=$(date "+%H:%M")

#audio_level=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%|\s)' | head -n1)

# get audio_level
# =$(pactl get-sink-volume @DEFAULT_SINK@)
# get the volume of the default sink, 
# then use grep -Po '\d+(?=%)' to extract sequences of digits 
# followed by a percentage sign, 
# and finally head -n 1 to get only the first match 
# (assuming left and right channels have the same volume).
audio_level=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1)

# get mute status
mute_status=$(pactl get-sink-mute @DEFAULT_SINK@)

battery_info=$(cat /sys/class/power_supply/BAT0/status)

# get Linux version info
linux_info=$(uname -r | cut -d '-' -f1)

# get the current username
USERNAME=$(whoami)

echo $USERNAME "  battery" $battery_info " " $mute_status " A" $audio_level"%  | " $day_formatted $date_formatted " " $time_formatted "  "
