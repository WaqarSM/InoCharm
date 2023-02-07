
//LED BUILT_IN is GPIO 33 
void setup() {
      // Serial.begin(115200);
  pinMode(33, OUTPUT); // Set the pin as output
}

// Remember that the pin work with inverted logic
// LOW to Turn on and HIGH to turn off
void loop() {
  digitalWrite(33, LOW); //Turn on
  delay (500); //Wait 1 sec
  digitalWrite(33, HIGH); //Turn off
  delay (100); //Wait 1 sec
}