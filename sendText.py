from machine import Pin, ESP32
import network
import time
from twilio.rest import Client

# Wifi information
wifi_ssid = 'YOUR_WIFI_SSID'
wifi_password = 'YOUR_WIFI_PASSWORD'

# Twilio account information
account_sid = 'YOUR_ACCOUNT_SID'
auth_token = 'YOUR_AUTH_TOKEN'
client = Client(account_sid, auth_token)

# Phone number to send the text message to
to_phone_number = '+14161234567'

# Phone number to send the text message from (should be a Twilio phone number)
from_phone_number = '+14160987654'

# Message to send in the text message
message = 'Button pressed!'

# Set the pin number for the button
button = Pin(12, Pin.IN, Pin.PULL_UP)

# Connect to wifi
wifi = network.WLAN(ESP32)
wifi.active(True)
wifi.connect(wifi_ssid, wifi_password)

while not wifi.isconnected():
    pass

print("Connected to wifi")

while True:
    # Check the state of the button
    if button.value() == 0:
        # Send the text message
        message = client.messages.create(
            body=message,
            from_=from_phone_number,
            to=to_phone_number
        )
        print(message.sid)
        # Add delay to prevent multiple messages
        time.sleep(1)