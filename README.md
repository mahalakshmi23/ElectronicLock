# ElectronicLock
Electronic lock which accepts a 4 digit pass code to unlock. Designed to work in Basys2 FPGA board.

Design an electronic combination lock. A four digit code can be entered by using the
pushbuttons and slider switches. As the number is entered, it should be displayed on the sevensegment
display. The number is entered as follows. Slider switches 3 through 0 should be used
to enter the binary value to be displayed on a particular digit of the seven-segment display.
Slider switch 3 corresponds to the most significant bit and slider switch 0 the least significant bit.
When a momentary push button is pressed the number represented on the slider switches should
be latched and displayed on the corresponding digit on the seven-segment display. After the
number has been entered, the user should move switch 4 from the low position to the high
position, and then back to the low position to indicate that the code entering is complete. When
the correct combination is entered and the device unlocks, the LEDs will flash. If two attempts
are made to unlock the device without correctly entering the combination, the device should be
deactivated for 20 seconds. The seven segment display will be used to display the state of the
lock. The states are: LOC (locked), UnLC (unlocked), and PAUS (deactivated). When the
device is unlocked, it can be locked by moving DIP switch 5 from the low to the high position,
and then back to the low position. The entire code must be entered within 30 seconds (from the
first button press to the last button press). The combination for your lock should be the your two
digit seat number in CSE 490/590, followed by the number of digits in your username, followed
by the sum of the first three digits mod 10. For example, if your seat number is 59, and your
username is csestaff, your combination would be 5982.
