#include "DHT.h" //importar biblioteca do DHT
#define dht_type DHT11 // definir tipo 

// definição de variáveis
//LDR
int ldr_sensorPin = A0;
int ldr_sensorValue1 = 0;
int ldr_sensorValue2 = 0;

//DHT
int dht_pin = A1;  
DHT dht_1 = DHT(dht_pin, dht_type); // definindo objeto tipo DHT



void setup() {
  Serial.begin(9600); // setar baudRate para 9600
  dht_1.begin();
}

void loop() {
  // DHT11 AMBIENTE 1
  float umidade1 = dht_1.readHumidity();         
  float temperatura1 = dht_1.readTemperature();  

  if (isnan(temperatura1) or isnan(umidade1)) { // checando se o valor for inváliado 

    Serial.println("Erro ao ler");
  
  } else { 
    
    //AMBIENTE 1
   
    Serial.print(umidade1); 

    Serial.print(";"); 
    
    Serial.print(temperatura1);

    Serial.print(";");
    
    //LDR
    ldr_sensorValue1 = analogRead(ldr_sensorPin); 
    Serial.println(ldr_sensorValue1);



    

  }
  delay(10000); // delay 👍
}
