#!/bin/bash

# ~/.local/bin/trix-bku.sh

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

# FLAGS
# --mkpath: create all missing destination directories
# --archive -a: archive mode (preserves permissions, timestamps, recursion, etc.)
# --verbose -v: verbose (optional, shows transferred files)
# --update -u: update (skip files that are newer in the destination)
# --existing: only update files that already exist in the destination (optional)
# --delete: delete files in destination not present in source 
# --progress: show progress during transfer
# --human-readable -h: display file sizes easy format for humans
# --dry-run -n: (optional) run a simulation without making any changes

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

handle_error() {
	echo -e "\nBackup FAILED!"
	echo -e "An error occurred on line ${BASH_LINENO[0]} while executing ${BASH_COMMAND}\n" 
#	echo >&2
	exit 1
}

# Set a trap to call the handle_error function upon any error (ERR)
trap 'handle_error' ERR

echo -e "\nBacking up local Trixie setup to ~/Backups ...\n"

# Backup local Trixie setup
bku_options=(--mkpath --archive --verbose --progress --human-readable)
bku_array=("sway" "waybar" "foot" "mako" "vim" "starship")
for bku_item in "${bku_array[@]}"; do
	rsync "${bku_options[@]}" "/home/docgwiz/.config/$bku_item/" "/home/docgwiz/Backups/trixiedust/$TIMESTAMP/$bku_item/"
done

# backup scripts
rsync "${bku_options[@]}" "/home/docgwiz/.local/bin/" "/home/docgwiz/Backups/trixiedust/$TIMESTAMP/bin/"

# backup config files
config_array=(".profile" ".gitconfig" ".bashrc" ".bash_aliases")
for config_item in "${config_array[@]}"; do
	rsync "${bku_options[@]}" "/home/docgwiz/$config_item" "/home/docgwiz/Backups/trixiedust/$TIMESTAMP/_configs/$config_item"
done

# backup environment
rsync "${bku_options[@]}" "/etc/environment" "/home/docgwiz/Backups/trixiedust/$TIMESTAMP/_configs/environment"

echo -e "\nTrixie backup complete."

