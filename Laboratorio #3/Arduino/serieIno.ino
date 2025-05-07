#include <SoftwareSerial.h>

// Pines para switches y botón
const int pinA = 2;
const int pinB = 3;
const int pinC = 4;
const int pinD = 5;

// Crear puerto serial en pines 10 (RX) y 11 (TX)
SoftwareSerial mySerial(10, 11);  // RX, TX

void setup() {
  Serial.begin(9600);     // Serial por USB (para depuración)
  mySerial.begin(9600);   // Segundo UART por Software

  pinMode(pinA, INPUT);
  pinMode(pinB, INPUT);
  pinMode(pinC, INPUT);
  pinMode(pinD, INPUT);
}

void loop() {
  // Leer switches y botón
  int a = digitalRead(pinA);
  int b = digitalRead(pinB);
  int c = digitalRead(pinC);
  int d = digitalRead(pinD);

  // Construir byte 0b0000ABCD
  byte data = (a << 3) | (b << 2) | (c << 1) | d;

  // Enviar por el puerto UART de software
  mySerial.write(data);
  Serial.write(data);

  // También puedes imprimirlo por el monitor serial
  Serial.print("Enviado: 0b");
  for (int i = 7; i >= 0; i--) {
    Serial.print(bitRead(data, i));
  }
  Serial.println();

  delay(200);
}
