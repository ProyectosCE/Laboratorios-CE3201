// Arduino SPI Master - Input Jugador 2 para FPGA
// Lee 3 switches como selección de columna (0–6) y envía por SPI a FPGA
// El envío se activa con un botón de confirmación

// Referencias:
// - https://docs.arduino.cc/learn/communication/spi/
// - https://docs.arduino.cc/built-in-examples/digital/Debounce/

#include <SPI.h>  // Biblioteca SPI estándar de Arduino

// Pines conectados a los switches (representan 3 bits)
const int SW0 = 2;
const int SW1 = 3;
const int SW2 = 4;

// Botón de confirmación para enviar jugada
const int BTN_CONFIRM = 5;

// Variable para almacenar el último valor enviado (debug opcional)
byte last_sent = 0;

// ------------------------
// Lectura del valor de columna
// ------------------------
// Convierte los 3 switches en un valor binario (0–7)
byte readColumnFromSwitches() {
  byte value = 0;
  value |= digitalRead(SW0) << 0;
  value |= digitalRead(SW1) << 1;
  value |= digitalRead(SW2) << 2;
  return value;
}

// ------------------------
// Configuración inicial de pines y SPI
// ------------------------
void setupPins() {
  pinMode(SW0, INPUT);
  pinMode(SW1, INPUT);
  pinMode(SW2, INPUT);

  // Botón con resistencia pull-up interna (activo en LOW)
  pinMode(BTN_CONFIRM, INPUT_PULLUP);

  // Inicializa SPI en modo maestro (MOSI = pin 11, SCK = 13, SS = 10 por defecto)
  SPI.begin(); 
  Serial.begin(9600); // Monitor serial para depuración opcional
}

// ------------------------
// Envío de columna a FPGA vía SPI
// ------------------------
// Usa SPI.transfer para enviar 1 byte (modo maestro simple)
// Configuración:
// - Clock: 500 kHz 
// - MSBFIRST: bit más significativo primero (estándar SPI)
// - MODE0: SPI mode 0 (CPOL=0, CPHA=0) → común en FPGAs
void sendColumnToFPGA(byte column) {
  SPI.beginTransaction(SPISettings(500000, MSBFIRST, SPI_MODE0)); 
  digitalWrite(SS, LOW);    // Activa la línea CS (Chip Select)
  SPI.transfer(column);     // Envía el byte de columna
  digitalWrite(SS, HIGH);   // Libera la línea CS
  SPI.endTransaction();

  last_sent = column;
  Serial.print("Columna enviada: ");
  Serial.println(column);
}

void loopLogic() {
  static bool sent = false;

  // Detecta flanco de bajada en el botón (activo en LOW)
  if (digitalRead(BTN_CONFIRM) == LOW && !sent) {
    byte col = readColumnFromSwitches();

    if (col <= 6) {  // Valida que la columna esté dentro del rango permitido
      sendColumnToFPGA(col);
      sent = true;  // Previene rebote (espera a soltar botón)
    }
  }

  // Espera que el botón se libere para permitir otro envío
  if (digitalRead(BTN_CONFIRM) == HIGH) {
    sent = false;
  }
}

void setup() {
  setupPins();  // Inicializa pines y SPI
  Serial.println("Arduino listo - Jugador 2 (SPI)");
}

void loop() {
  loopLogic();  // Ejecuta la lógica del juego
}
