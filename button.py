from machine import Pin

# Set the pin number for the button and LED
button = Pin(12, Pin.IN, Pin.PULL_UP)
led = Pin(2, Pin.OUT)

while True:
    # Check the state of the button
    if button.value() == 0:
        # Turn the LED on
        led.on()
    else:
        # Turn the LED off
        led.off()