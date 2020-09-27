#!/bin/ksh
# Dependencies: This scripts need the package "figlet" to generate ascii art

# Some vars
SPACER='        '
FILES_DIR='files/motd/'
BODY_COLOR1='[38;05;052m'
BODY_COLOR2='[38;05;088m'
BODY_COLOR3='[38;05;124m'
BODY_COLOR4='[38;05;160m'
BODY_COLOR5='[38;05;196m'
BODY_DEFAULT_COLOR='[38;05;015m'

# Menu, arguments, help
while test $# -gt 0; do
        case "$1" in
                -h|--help)
                        echo "$package - generate a banner for hackfest 2013 VMs"
                        echo " "
                        echo "$package [options] OUTPUT_FILE"
                        echo " "
                        echo "options:"
                        echo "-h, --help                show brief help"
                        echo "-z, --zone=ACTION		specify a zone (MGMT, PUBLIC, CHALS)"
                        echo "-o, --owner=OWNER      	specify an owner (HF)"
                        exit 0
                        ;;
                -z)
                        shift
                        if test $# -gt 0; then
                                export ZONE=$1
                        else
                                echo "no zone specified"
                                exit 1
                        fi
                        shift
                        ;;
                --zone*)
                        export ZONE=`echo $1 | sed -e 's/^[^=]*=//g'`
                        shift
                        ;;
                -o)
                        shift
                        if test $# -gt 0; then
                                export OWNER=$1
                        else
                                echo "no owner specified"
                                exit 1
                        fi
                        shift
                        ;;
                --owner*)
                        export OWNER=`echo $1 | sed -e 's/^[^=]*=//g'`
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

#asciiZone=`figlet -f small ZONE: $ZONE`
#asciiOwner=`figlet -f small OWNER: $OWNER`
asciiZone="ZONE: $ZONE"
asciiOwner="OWNER: $OWNER"
if [ -z "$OUT_FILE" ] 
then
	# Step 1: Print Header banner
	cat $FILES_DIR''motd.header 
	echo "$SPACER$BODY_COLOR5$asciiZone"	
	echo "$SPACER$BODY_COLOR5$asciiOwner"	

	# Step 2: Print zone
	#echo "$SPACER"$BODY_COLOR1''"`echo "$asciiZone" | head -1 | tail -1`"
	#echo "$SPACER"$BODY_COLOR2''"`echo "$asciiZone" | head -2 | tail -1`"
	#echo "$SPACER"$BODY_COLOR3''"`echo "$asciiZone" | head -3 | tail -1`"
	#echo "$SPACER"$BODY_COLOR4''"`echo "$asciiZone" | head -4 | tail -1`"
	#echo "$SPACER"$BODY_COLOR5''"`echo "$asciiZone" | head -5 | tail -1`"

	# Step 3: Print owner
	#echo "$SPACER"$BODY_COLOR1''"`echo "$asciiOwner" | head -1 | tail -1`"
	#echo "$SPACER"$BODY_COLOR2''"`echo "$asciiOwner" | head -2 | tail -1`"
	#echo "$SPACER"$BODY_COLOR3''"`echo "$asciiOwner" | head -3 | tail -1`"
	#echo "$SPACER"$BODY_COLOR4''"`echo "$asciiOwner" | head -4 | tail -1`"
	#echo "$SPACER"$BODY_COLOR5''"`echo "$asciiOwner" | head -5 | tail -1`"

	# Step 4: Set default color back (otherwise, it overwrites shell color)
	echo $BODY_DEFAULT_COLOR
else
	# Step 0: Create a new file
	#echo '' > $OUT_FILE

	# Step 1: Print Header banner
	cat $FILES_DIR''motd.header 						> $OUT_FILE
	echo "$SPACER$BODY_COLOR5$asciiZone"					>> $OUT_FILE
	echo "$SPACER$BODY_COLOR5$asciiOwner"					>> $OUT_FILE

	# Step 2: Print zone
	#echo "$SPACER"$BODY_COLOR1''"`echo "$asciiZone" | head -1 | tail -1`"	>> $OUT_FILE
	#echo "$SPACER"$BODY_COLOR2''"`echo "$asciiZone" | head -2 | tail -1`"	>> $OUT_FILE
	#echo "$SPACER"$BODY_COLOR3''"`echo "$asciiZone" | head -3 | tail -1`"	>> $OUT_FILE
	#echo "$SPACER"$BODY_COLOR4''"`echo "$asciiZone" | head -4 | tail -1`"	>> $OUT_FILE
	#echo "$SPACER"$BODY_COLOR5''"`echo "$asciiZone" | head -5 | tail -1`"	>> $OUT_FILE

	# Step 3: Print owner
	#echo "$SPACER"$BODY_COLOR1''"`echo "$asciiOwner" | head -1 | tail -1`"	>> $OUT_FILE
	#echo "$SPACER"$BODY_COLOR2''"`echo "$asciiOwner" | head -2 | tail -1`"	>> $OUT_FILE
	#echo "$SPACER"$BODY_COLOR3''"`echo "$asciiOwner" | head -3 | tail -1`"	>> $OUT_FILE
	#echo "$SPACER"$BODY_COLOR4''"`echo "$asciiOwner" | head -4 | tail -1`"	>> $OUT_FILE
	#echo "$SPACER"$BODY_COLOR5''"`echo "$asciiOwner" | head -5 | tail -1`"	>> $OUT_FILE

	# Step 4: Set default color back (otherwise, it overwrites shell color)
	echo $BODY_DEFAULT_COLOR						>> $OUT_FILE
fi
