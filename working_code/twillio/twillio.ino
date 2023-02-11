/*********
  Rui Santos
  Complete project details at https://RandomNerdTutorials.com/send-sms-esp32-twilio/
  
  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files.  
  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
*********/

// Library example: https://github.com/ademuri/twilio-esp32-client

#include "twilio.hpp"

// Set these - but DON'T push them to GitHub!
static const char *ssid = "Waqar";
static const char *password = "FLLFLLFLL";

// Values from Twilio (find them on the dashboard)
static const char *account_sid = "ACdb6dbe1f26c50e6777281b4b76c1a65c";
static const char *auth_token = "15bff5b989471aec8c47f94ebb2fc2d9";
// Phone number should start with "+<countrycode>"
static const char *from_number = "+13855267387";

// You choose!
// Phone number should start with "+<countrycode>"
static const char *to_number = "+16478855292";
static const char *message = " SAMPLE MESSAGE! \n JA-CIBC-2023 \n ";

Twilio *twilio;

void setup() {
  Serial.begin(115200);
  pinMode(4, OUTPUT); // Set the pin as output
  Serial.print("Connecting to WiFi network ;");
  Serial.print(ssid);
  Serial.println("'...");
  WiFi.begin(ssid, password);
  WiFi.mode(WIFI_STA); // SETS TO STATION MODE!

  while (WiFi.status() != WL_CONNECTED) {
    Serial.println("Connecting...");
    delay(500);
  }
  Serial.println("Connected!");

  twilio = new Twilio(account_sid, auth_token);

  delay(1000);
  String response;
  bool success = twilio->send_message(to_number, from_number, message, response);
  if (success) {
    Serial.println("Sent message successfully!");
  } else {
    Serial.println(response);
  }
}

void loop() {
  digitalWrite(4, LOW); //Turn on
  delay (100); //Wait 1 sec
  digitalWrite(4, HIGH); //Turn off
  delay (100); //Wait 1 sec
  
}
