#!/usr/bin/env python3

import cv2
import time

# Constants for line detection
LINE_THICKNESS = 2
LINE_COLOR = (0, 255, 0)  # Green color
MOVEMENT_THRESHOLD = 500  # Adjust this value based on your needs
RESIZE_SCALE = 1.5  # Adjust the scale factor to resize the image
RESET_DELAY = 5  # Delay in seconds after pressing 'r'

# Initialize webcam
cap = cv2.VideoCapture("/dev/video2")  # Use 0 for the default webcam

# Read the first frame
ret, prev_frame = cap.read()
prev_gray = cv2.cvtColor(prev_frame, cv2.COLOR_BGR2GRAY)

# Detect the line
rows, cols = prev_gray.shape
line_start = (0, rows // 2)
line_end = (cols, rows // 2)

# Create a resizable window
cv2.namedWindow("Line Detection", cv2.WINDOW_NORMAL)
cv2.resizeWindow("Line Detection", int(cols * RESIZE_SCALE), int(rows * RESIZE_SCALE))  # Adjust the size as desired

# Initialize the line counter
line_counter = 0

# Variable to track reset time
last_reset_time = time.time()

while True:
    # Read the current frame
    ret, frame = cap.read()
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # Calculate the absolute difference between the current and previous frame
    frame_diff = cv2.absdiff(gray, prev_gray)

    # Apply a threshold to create a binary image
    _, binary = cv2.threshold(frame_diff, 30, 255, cv2.THRESH_BINARY)

    # Find contours of the binary image
    contours, _ = cv2.findContours(binary, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    # Check if any contour intersects the line
    line_broken = False
    for contour in contours:
        (x, y, w, h) = cv2.boundingRect(contour)
        if y < rows // 2 + LINE_THICKNESS and y + h > rows // 2 - LINE_THICKNESS:
            line_broken = True
            break

    # Draw the line
    cv2.line(frame, line_start, line_end, LINE_COLOR, LINE_THICKNESS)

    # Increment or reset the line counter based on user input
    key = cv2.waitKey(1) & 0xFF
    if key == ord('r'):  # Reset the line counter when 'r' is pressed
        line_counter = 0
        last_reset_time = time.time()
    elif key == ord('q'):  # Exit the loop if 'q' is pressed
        break

    # Delay for 5 seconds after 'r' is pressed
    if time.time() - last_reset_time < RESET_DELAY:
        continue

    # Increment the line counter if the line is broken
    if line_broken:
        line_counter += 1

    # Resize the frame for display
    resized_frame = cv2.resize(frame, None, fx=RESIZE_SCALE, fy=RESIZE_SCALE)

    # Display the frame and line counter
    cv2.putText(resized_frame, f"Line Counter: {line_counter}", (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 1, LINE_COLOR, 2)
    cv2.imshow("Line Detection", resized_frame)

    # Update the previous frame and its grayscale version
    prev_gray = gray.copy()

# Release the webcam and close windows
cap.release()
cv2.destroyAllWindows()
