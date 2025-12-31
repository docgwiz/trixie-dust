#!/bin/bash

# location: ~/.local/bin/

# See manual:
# https://manpages.debian.org/trixie/rsync/rsync.1.en.html

# Source path WITH a trailing slash (/): 
# This tells rsync to copy the contents of the source directory. 
# The files and subdirectories within the source are copied directly
# into the destination directory.

# Source path WITHOUT a trailing slash: 
# This tells rsync to copy the source directory itself 
# into the destination. 
# An extra directory level with the source directory's name 
# is created inside the destination.

# Always use absolute paths (paths starting with /) in scripts
# to ensure the command behaves consistently 
# regardless of the current working directory (CWD)
# where the script is executed. 
# The shell expands relative paths based on 
# the CWD before rsync runs.

# Set TIMESTAMP variable
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Set up error handling
handle_error() {
	echo -e "\nFAILED!"
	echo -e "An error occurred on line ${BASH_LINENO[0]} while executing ${BASH_COMMAND}\n" 
#	echo >&2
	exit 1
}

# Set a trap to call the handle_error function upon any error (ERR)
trap 'handle_error' ERR


# RSYNC FLAGS (OPTIONS)
# --mkpath: create all missing destination directories
# --archive -a: archive mode (preserves permissions, timestamps, recursion, etc.)
# --verbose -v: verbose (optional, shows transferred files)
# --update -u: update (skip files that are newer in the destination)
# --existing: only update files that already exist in the destination (optional)
# --delete: delete files in destination not present in source 
# --progress: show progress during transfer
# --human-readable -h: display file sizes easy format for humans
# --dry-run -n: (optional) run a simulation without making any changes


###
### CREATE ARRAYS FOR RSYNC OPTIONS
###
# To pass rsync options using a variable in a Bash script, 
# the recommended method is to use an array. 
# Storing options in a string variable and expanding it in the 
# command can lead to issues with word splitting and quoting, 
# especially with options that contain spaces or special characters 
# (like --exclude '...').

# Array for rsync options
rsync_opts=(--dry-run --archive --update --delete --verbose --progress --human-readable)

# Array for rsync options + mkpath (used for rsyncing to ~/Backups)
rsync_opts_bku=(--archive --verbose --progress --human-readable --mkpath)

###
### CREATE ARRAYS FOR RSYNC FOLDER/FILE NAMES
###
#rsync_folders=("sway" "waybar" "foot" "mako" "vim" "starship")
#rsync_dotfiles=(".profile" ".bashrc" ".bash_aliases" ".gitconfig")

local_path="/home/docgwiz/"
repo_path="/home/docgwiz/gitrepos/trixiedust/"
backup_path="/home/docgwiz/Backups/trixiedust/$TIMESTAMP/"

rsync_list[0]=".config/sway/"
rsync_list[1]=".config/waybar/"
rsync_list[2]=".config/foot/"
rsync_list[3]=".config/mako/"
rsync_list[4]=".config/vim/"
rsync_list[5]=".config/starship/"
rsync_list[6]=".profile"
rsync_list[7]=".bashrc"
rsync_list[8]=".bash_aliases"
rsync_list[9]=".gitconfig"
rsync_list[10]=".local/bin/"


###
### BACKUP LOCAL TRIXIE SETUP (USING RSYNC)
###

echo -e "\nBacking up local Trixie setup to ~/Backups ...\n"

echo -e "Backup OPTIONS: ${rsync_opts_bku[@]}\n"

for rsync_item in "${rsync_list[@]}"; do
	echo -e "Backing up $local_path$rsync_item to $backup_path$rsync_item\n"
	rsync "${rsync_opts_bku[@]}" "$local_path$rsync_item" "$backup_path$rsync_item"
done

echo -e "\nTrixie backup complete."


###
### RSYNC LOCAL TRIXIE SETUP TO GIT REPO
###

echo -e "\nRsyncing files from local Trixie setup to trixiedust repo ...\n"

echo -e "Rsync OPTIONS: ${rsync_opts[@]}\n"

for rsync_item in "${rsync_list[@]}"; do
	echo -e "Rsyncing $local_path$rsync_item to $repo_path$rsync_item\n"
	rsync "${rsync_opts_bku[@]}" "$local_path$rsync_item" "$repo_path$rsync_item"
done

echo -e "\nTrixie rsync complete."


###
### RSYNC GIT REPO TO LOCAL TRIXIE SETUP
###

#echo -e "\nRsyncing files from trixiedust repo to local Trixie setup ...\n"

#for trix_item in "${trix_array[@]}"; do
#	rsync --dry-run --archive --verbose --update --delete --progress --human-readable "/home/docgwiz/gitrepos/trixiedust/$trix_item/" "/home/docgwiz/.config/$trix_item/"
# done

#echo -e "\nRsync complete."

