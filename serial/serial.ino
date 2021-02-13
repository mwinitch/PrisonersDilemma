// This file creates the serial stream from interacting with the joystick, buttons, and switch
int xyzPins[] = {13, 12, 14};   //x,y,z pins
void setup() {
  Serial.begin(115200);
  pinMode(xyzPins[2], INPUT_PULLUP);
  pinMode(25, INPUT_PULLUP);
  pinMode(32, INPUT_PULLUP);
  pinMode(18, INPUT_PULLUP);
}

void loop() {
  int xVal = analogRead(xyzPins[0]);
  int yVal = analogRead(xyzPins[1]);
  int zVal = digitalRead(xyzPins[2]);
  Serial.print(xVal);
  Serial.print(" ");
  Serial.print(yVal);
  Serial.print(" ");
  int buttonVal1 = digitalRead(25);
  int buttonVal2 = digitalRead(32);
  Serial.print(buttonVal1);
  Serial.print(" ");
  Serial.print(buttonVal2);
  Serial.print(" ");
  int switching = digitalRead(18);
  Serial.print(switching);
  Serial.print('\n');
  delay(100);
}
