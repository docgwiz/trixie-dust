#!/bin/bash

# \n = new line

# \[\e[1;32m\] = bold;green
# \h = host

# \[\e[1m\] = non-bold;defaultcolor (use 1 for bold)
# / = forward slash (path separator)

# \[\e[1;36m\] =  bold;cyan
# \$ = root or standard user indicator
# \u = user

# \[\e[1;35m\] = bold;pink
# \w = current working directory

# \[\e[1;33m\] = bold;yellow
# : = colon 

PS1="\n@\[\e[1;32m\]\h \n\[\e[1;36m\]\\$\u \[\e[1;33m\]\w \[\e[0m\]: "

# NOTE: "source setmyps1.sh" to execute
# NOTE: a double reverse-slash may be needed for some variables (e.g., $)
