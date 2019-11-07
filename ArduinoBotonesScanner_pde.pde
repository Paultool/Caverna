/*
PABLO NIETO 2011
PAULTOOL@GMAIL.COM

SWITCH SIMPLE SERIAL- LED
AL OPRIMIR EL BOTON DEL PUERTO 7
SE ENCIENDE EL LED DEL PUERTO 8
Y SE ENVIA EL STATUS POR PUERTO SERIAL 

*/

//LED TIPO DE IIMAGEN
int ledRetrato =  12;  //RETRATO
int ledPaisaje =  13;  //PAISAJE

//BOTONES PARA SELECCION DE TIPO DE IMAGEN 
const int BotonRetrato = 8;//RETRATO
int BotonRetratoState = 0;

const int BotonPaisaje = 9;//PAISAJE
int BotonPaisajeState = 0;

const int BotonScanea = 10;//SCANEA
int BotonScaneaState = 0;
// The setup() method runs once, when the sketch starts

void setup()   {

  // Inicia entrads/salidas
  //RETRAT0
  pinMode(ledRetrato, OUTPUT);
  pinMode(BotonRetrato, INPUT);
  digitalWrite(BotonRetrato, HIGH); //Activa el pull-up 
  //PAISAJE
  pinMode(ledPaisaje, OUTPUT);
  pinMode(BotonPaisaje, INPUT);
  digitalWrite(BotonPaisaje, HIGH); //Activa el pull-up 
  //SCANEA
  pinMode(BotonScanea, INPUT);
  digitalWrite(BotonScanea, HIGH); //Activa el pull-up 
  //INICIA PTO. SERIAL
  Serial.begin(9600);
}

// the loop() method runs over and over again,
// as long as the Arduino has power

void loop()                     
{
  BotonRetratoState = digitalRead(BotonRetrato);//RETRATO
  BotonPaisajeState = digitalRead(BotonPaisaje);//PAISAJE
  BotonScaneaState = digitalRead(BotonScanea);//SCANEA
   
  Serial.read();
  
  //RETRATO
  if (BotonRetratoState == LOW) {
    digitalWrite(ledRetrato, HIGH);  //on   led8 
    digitalWrite(ledPaisaje, LOW);   //off  led9
    Serial.write(1);
    
  }
  //PAISAJE
  if (BotonPaisajeState == LOW){
    digitalWrite(ledPaisaje, HIGH);  //on   led9 
    digitalWrite(ledRetrato, LOW);   //off  led8
    Serial.write(2); 
  }
  
  //SCANEA
  if (BotonScaneaState == LOW) {
    Serial.write(3);     
  }if (BotonScaneaState == HIGH){
    Serial.write(4);
  }
}
