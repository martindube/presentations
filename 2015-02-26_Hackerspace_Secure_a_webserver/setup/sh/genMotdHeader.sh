#!/bin/ksh
# Dependencies: This scripts need the package "figlet" to generate ascii art

# Some vars
SPACER=''
FILES_DIR='files/motd/'
BODY_COLOR1='[38;05;022m'
BODY_COLOR2='[38;05;028m'
BODY_COLOR3='[38;05;034m'
BODY_COLOR4='[38;05;040m'
BODY_COLOR5='[38;05;046m'
BODY_DEFAULT_COLOR='[38;05;015m'

# Menu, arguments, help
while test $# -gt 0; do
        case "$1" in
                -h|--help)
                        echo "$package - generate a banner for hackfest 2014 VMs"
                        echo " "
                        echo "$package [options] OUTPUT_FILE"
                        echo " "
                        echo "options:"
                        echo "-h, --help                show brief help"
                        echo "-t, --title=NAME		specify a title (HF 2014)"
                        exit 0
                        ;;
                -t)
                        shift
                        if test $# -gt 0; then
                                export TITLE=$1
                        else
                                echo "no title specified"
                                exit 1
                        fi
                        shift
                        ;;
                --title*)
                        export TITLE=`echo $1 | sed -e 's/^[^=]*=//g'`
                        shift
                        ;;
                *)
                        if test $# -gt 0; then
                                export OUT_FILE=$1
                        else
                                echo "no file specified"
                                exit 1
                        fi
                        break
                        ;;
        esac
done

# Some validations
if [ -z "$TITLE" ] 
then
	echo There are missing arguments
	exit 1
fi

# The script output header in this format:
#    __  ________   ___   ____ _____ __
#   / / / / ____/  |__ \ / __ <  / // /
#  / /_/ / /_      __/ // / / / / // /_
# / __  / __/     / __// /_/ / /__  __/
#/_/ /_/_/       /____/\____/_/  /_/   
asciiZone=`figlet -f slant $TITLE`

if [ -z "$OUT_FILE" ] 
then

	echo "$SPACER"$BODY_COLOR1''"`echo "$asciiZone" | head -1 | tail -1`"
	echo "$SPACER"$BODY_COLOR2''"`echo "$asciiZone" | head -2 | tail -1`"
	echo "$SPACER"$BODY_COLOR3''"`echo "$asciiZone" | head -3 | tail -1`"
	echo "$SPACER"$BODY_COLOR4''"`echo "$asciiZone" | head -4 | tail -1`"
	echo "$SPACER"$BODY_COLOR5''"`echo "$asciiZone" | head -5 | tail -1`"

	# Step 4: Set default color back (otherwise, it overwrites shell color)
	echo $BODY_DEFAULT_COLOR
else
	# Step 0: Create a new file
	#echo '' > $OUT_FILE
	echo "$SPACER"$BODY_COLOR1''"`echo "$asciiZone" | head -1 | tail -1`"	> $OUT_FILE
	echo "$SPACER"$BODY_COLOR2''"`echo "$asciiZone" | head -2 | tail -1`"	>> $OUT_FILE
	echo "$SPACER"$BODY_COLOR3''"`echo "$asciiZone" | head -3 | tail -1`"	>> $OUT_FILE
	echo "$SPACER"$BODY_COLOR4''"`echo "$asciiZone" | head -4 | tail -1`"	>> $OUT_FILE
	echo "$SPACER"$BODY_COLOR5''"`echo "$asciiZone" | head -5 | tail -1`"	>> $OUT_FILE

	# Step 4: Set default color back (otherwise, it overwrites shell color)
	echo $BODY_DEFAULT_COLOR						>> $OUT_FILE
fi
