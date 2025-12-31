#!/bin/bash

# ~/.local/bin/trix-local2git.sh

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
# --archive -a: archive mode (preserves permissions, timestamps, recursion, etc.)
# --verbose -v: verbose (optional, shows transferred files)
# --update -u: update (skip files that are newer in the destination)
# --existing: only update files that already exist in the destination (optional)
# --delete: delete files in destination not present in source 
# --progress: show progress during transfer
# --human-readable -h: display files sizes in easy format for humans
# --dry-run -n: (optional) run a simulation without making any changes


echo -e "\nRsyncing files from local Trixie setup to trixiedust repo ...\n"

# rsync --archive --verbose --update --progress "/home/docgwiz/Downloads/TEST1/" "/home/docgwiz/Downloads/TEST2/"

# rsync sway files
rsync --archive --verbose --update --delete --progress --human-readable "/home/docgwiz/.config/sway/" "/home/docgwiz/gitrepos/trixiedust/sway/"

# rsync waybar files
rsync --archive --verbose --update --delete --progress --human-readable "/home/docgwiz/.config/waybar/" "/home/docgwiz/gitrepos/trixiedust/waybar/"

# rsync foot files 
rsync --archive --verbose --update --delete --progress --human-readable "/home/docgwiz/.config/foot/" "/home/docgwiz/gitrepos/trixiedust/foot/"

# rsync mako files
rsync --archive --verbose --update --delete --progress --human-readable "/home/docgwiz/.config/mako/" "/home/docgwiz/gitrepos/trixiedust/mako/"

# rsync scripts
rsync --archive --verbose --update --delete --progress --human-readable "/usr/local/bin/" "/home/docgwiz/gitrepos/trixiedust/_scripts/"

# rsync various config files
rsync --archive --verbose --update --progress --human-readable "/home/docgwiz/.profile" "/home/docgwiz/gitrepos/trixiedust/_configs/.profile"
rsync --archive --verbose --update --progress --human-readable "/home/docgwiz/.gitconfig" "/home/docgwiz/gitrepos/trixiedust/_configs/.gitconfig"
rsync --archive --verbose --update --progress --human-readable "/home/docgwiz/.bash_aliases" "/home/docgwiz/gitrepos/trixiedust/_configs/.bash_aliases"
rsync --archive --verbose --update --progress --human-readable "/home/docgwiz/.bashrc" "/home/docgwiz/gitrepos/trixiedust/_configs/.bashrc"
rsync --archive --verbose --update --progress --human-readable "/etc/vim/vimrc" "/home/docgwiz/gitrepos/trixiedust/_configs/vimrc"
rsync --archive --verbose --update --progress --human-readble "/etc/environment" "/home/docgwiz/gitrepos/trixiedust/_configs/environment"

echo -e "\nSynchronization complete."

