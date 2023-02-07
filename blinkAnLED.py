
from machine import Pin
import time

# Set the pin number that the LED is connected to
led = Pin(2, Pin.OUT)

while True:
    # Turn the LED on
    led.on()
    # Wait for 1 second
    time.sleep(1)
    # Turn the LED off
    led.off()
    # Wait for 1 second
    time.sleep(1)