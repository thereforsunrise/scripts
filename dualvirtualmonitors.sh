#!/bin/bash

set -e

get_primary_display_details() {
  xrandr --query | \
    grep '\bconnected\b' | \
    grep 'primary'
}

TMP_FILE=$(mktemp)

COMMAND="$1"

PRIMARY_DISPLAY_DETAILS=$(get_primary_display_details)

DISPLAY_NAME=$(echo "$PRIMARY_DISPLAY_DETAILS" | cut -f1 -d' ')
RESOLUTION=$(echo "$PRIMARY_DISPLAY_DETAILS" | cut -f4 -d' ')

WIDTH_PX=$(echo "$RESOLUTION"  | cut -f1 -d'x')
HEIGHT_PX=$(echo "$RESOLUTION" | cut -f2 -d'x')
WIDTH_MM=$(echo "$PRIMARY_DISPLAY_DETAILS"  | cut -f13 -d' ' | sed 's/mm//g')
HEIGHT_MM=$(echo "$PRIMARY_DISPLAY_DETAILS"  | cut -f15 -d' ' | sed 's/mm//g')

HALF_WIDTH_PX=$(($WIDTH_PX / 2))
HALF_HEIGHT_PX=$(($HEIGHT_PX / 2))
HALF_WIDTH_MM=$(($WIDTH_MM / 2))
HALF_WIDTH_MM_PLUS_ONE=$(($HALF_WIDTH_MM + 1))

echo "Temp script is $TMP_FILE"

# RUNNNING DIRECTLY DOESNT WORK ATM - SOMETHINNG TO DO WITH DISPLAY ENV VAR?
if [[ "$COMMAND" == "add" ]]; then
  cat <<EOF > "$TMP_FILE"
#!/bin/bash
xrandr --setmonitor "${DISPLAY_NAME}-1" ${HALF_WIDTH_PX}/${HALF_WIDTH_MM}x${HALF_HEIGHT_PX}/${HEIGHT_MM}+0+0 $DISPLAY
xrandr --setmonitor "${DISPLAY_NAME}-2" ${HALF_WIDTH_PX}/${HALF_WIDTH_MM_PLUS_ONE}x${HALF_HEIGHT_PX}/${HEIGHT_MM}+${HALF_WIDTH_PX}+0 none
i3-msg restart
EOF
cat "$TMP_FILE"
else
  cat <<EOF > "$TMP_FILE"
#!/bin/bash
xrandr --delmonitor "${DISPLAY_NAME}-1"
xrandr --delmonitor "${DISPLAY_NAME}-2"
i3-msg restart
EOF
fi

cat "$TMP_FILE"
chmod 755 "$TMP_FILE"
