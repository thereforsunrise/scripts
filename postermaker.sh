#!/usr/bin/env bash

PRINT="$1"

STDIN="$(cat -)"
OUTPUT_FILE="poster-$(date --iso-8601='seconds').png"

A4_SIZE="595x842"
BACKGROUND_COLOUR="WHITE"
BORDER_COLOUR="WHITE"
BORDER_SIZE="20x20"
FONT="Times-Roman"

convert \
  -background "$BACKGROUND_COLOUR" \
  -border "$BORDER_SIZE" \
  -bordercolor "$BORDER_COLOUR" \
  -font "$FONT" \
  -size "$A4_SIZE" \
  caption:"$STDIN" \
  "$OUTPUT_FILE"

echo "Generated $OUTPUT_FILE"

[ "$PRINT" = "yes" ] && \
  echo "Printing $OUTPUT_FILE" && \
  lpr "$OUTPUT_FILE"

echo "Not printing $OUTPUT_FILE"
