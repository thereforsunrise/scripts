#!/usr/bin/env python3

import cv2
import numpy as np

# Constants
LINE_POSITION = 300  # Y-coordinate of the horizontal line
NEON_ORANGE_LOWER = np.array([10, 100, 100])
NEON_ORANGE_UPPER = np.array([25, 255, 255])
DELAY_RESET = 5  # Delay in seconds for resetting the line counter

# Global variables
line_counter = 0
reset_counter = False
object_crossed = False  # Flag to track if the object has crossed the line

# Function to draw the line and counter on the frame
def draw_line_counter(frame):
    global line_counter
    cv2.line(frame, (0, LINE_POSITION), (frame.shape[1], LINE_POSITION), (0, 255, 0), 2)
    cv2.putText(frame, f"Line Counter: {line_counter}", (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)

# Function to process the frame and detect the neon orange object
def process_frame(frame):
    global line_counter, reset_counter, object_crossed

    # Convert frame to HSV color space
    hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)

    # Threshold the frame to extract neon orange regions
    mask = cv2.inRange(hsv, NEON_ORANGE_LOWER, NEON_ORANGE_UPPER)

    # Find contours of neon orange objects
    contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    # Process each contour
    for contour in contours:
        area = cv2.contourArea(contour)

        # Check if contour area is above a certain threshold
        if area > 1000:
            # Calculate centroid of the contour
            M = cv2.moments(contour)
            cX = int(M["m10"] / M["m00"])
            cY = int(M["m01"] / M["m00"])

            # Check if the centroid is above the line
            if cY < LINE_POSITION:
                # If the object has not crossed the line, increment line counter and set the flag
                if not object_crossed:
                    line_counter += 1
                    object_crossed = True

                cv2.drawContours(frame, [contour], -1, (0, 255, 0), 2)
                cv2.circle(frame, (cX, cY), 7, (0, 255, 0), -1)
            else:
                object_crossed = False

    # Draw the line and counter on the frame
    draw_line_counter(frame)

    # Display the frame
    cv2.imshow("Object Detection", frame)

    # Reset the line counter if requested
    if reset_counter:
        reset_counter = False
        line_counter = 0
        cv2.putText(frame, "Counter Reset", (10, 70), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 2)
        cv2.imshow("Object Detection", frame)
        cv2.waitKey(DELAY_RESET * 1000)

# Main program
def main():
    # Initialize video capture device
    cap = cv2.VideoCapture('/dev/video2')

    while True:
        # Read frame from the video capture device
        ret, frame = cap.read()

        # Check if frame is successfully read
        if not ret:
            break

        # Process the frame
        process_frame(frame)

        # Check for user input
        key = cv2.waitKey(1) & 0xFF

        # Check if 'r' key is pressed to reset the line counter
        if key == ord('r'):
            global reset_counter
            reset_counter = True

        # Check if 'q' key is pressed to quit the program
        if key == ord('q'):
            break

    # Release the video capture device and close windows
    cap.release()
    cv2.destroyAllWindows()

# Run the main program
if __name__ == '__main__':
    main()
