#!/bin/bash

# ~/.local/bin/trix-git2local.sh

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


# Backup local Trixie setup
./trix-bku.sh
if [ $? -eq 0 ]; then
    echo -e "Success!\n"
else
    echo -e "ERROR! Trixie backup failed.\n"
fi

read -p "Do you want to continue with the next step? (y/N): " choice

case "$choice" in
    y|Y )
        echo -e "\nContinuing ..."
        # Place the rest of your script commands here
        ;;
    n|N )
        echo -e "\nAborting."
        exit 1 # Exit with a non-zero status to indicate a graceful stop
        ;;
    * )
        echo -e "\nInvalid input. Aborting."
        exit 1
        ;;
esac

echo -e "\nRsyncing files from trixiedust repo to local Trixie setup ...\n"

# Rsync trixiedust repo to local Trixie setup
trix_array=("sway" "waybar" "foot" "mako")
for trix_item in "${trix_array[@]}"; do
	rsync --dry-run --archive --verbose --update --delete --progress --human-readable "/home/docgwiz/gitrepos/trixiedust/$trix_item/" "/home/docgwiz/.config/$trix_item/"
done

# rsync sway files
#rsync --archive --verbose --update --delete --progress --human-readable "/home/docgwiz/gitrepos/trixiedust/sway/" "/home/docgwiz/.config/sway/"

# rsync waybar files
#rsync --archive --verbose --update --delete --progress --human-readable "/home/docgwiz/gitrepos/trixiedust/waybar/" "/home/docgwiz/.config/waybar/"

# rsync foot files 
#rsync --archive --verbose --update --delete --progress --human-readable "/home/docgwiz/gitrepos/trixiedust/foot/" "/home/docgwiz/.config/foot/"

# rsync mako files
#rsync --archive --verbose --update --delete --progress --human-readable "/home/docgwiz/gitrepos/trixiedust/mako/" "/home/docgwiz/.config/mako/"

# rsync scripts
#rsync --archive --verbose --update --delete --progress --human-readable "/usr/local/bin/" "/home/docgwiz/gitrepos/trixiedust/_scripts/"

# rsync various config files
#rsync --archive --verbose --update --progress --human-readable "/home/docgwiz/.profile" "/home/docgwiz/gitrepos/trixiedust/_configs/.profile"
#rsync --archive --verbose --update --progress --human-readable "/home/docgwiz/.gitconfig" "/home/docgwiz/gitrepos/trixiedust/_configs/.gitconfig"
#rsync --archive --verbose --update --progress --human-readable "/home/docgwiz/.bash_aliases" "/home/docgwiz/gitrepos/trixiedust/_configs/.bash_aliases"
#rsync --archive --verbose --update --progress --human-readable "/home/docgwiz/.bashrc" "/home/docgwiz/gitrepos/trixiedust/_configs/.bashrc"
#rsync --archive --verbose --update --progress --human-readable "/etc/vim/vimrc" "/home/docgwiz/gitrepos/trixiedust/_configs/vimrc"
#rsync --archive --verbose --update --progress --human-readble "/etc/environment" "/home/docgwiz/gitrepos/trixiedust/_configs/environment"

echo -e "\nSynchronization complete."

