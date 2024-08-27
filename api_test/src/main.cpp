#include <Arduino.h>
#include <Servo.h>

Servo rollServo;

int val = 0;    // variable to read the value from the analog pin

void setup() {
    pinMode(LED_BUILTIN, OUTPUT);

    rollServo.attach(9);
}

// the loop function runs over and over again forever
void loop() {
    for (val = 0; val <= 180; val += 1) {
        rollServo.write(val);
        delay(15);
    }

    for (val = 180; val >= 0; val -= 1) {
        rollServo.write(val);
        delay(15);
    }
}
