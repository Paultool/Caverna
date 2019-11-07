import processing.serial.*;
Serial myPort;  // The serial port

int NoteStatus = 0;
int NoteStatus2 = 0;

int Scanea = 0;
int NoScanea = 0;

//ARCHIVO QUE VA A A LEER C# DESPUES DE SCANEAR LA IMAGEN
//PARA ENVIARLO COMO SEGUNDO PARAMETRO COMANDO OSC
String Archivo = "C:/Users/DELL/Desktop/Cliente Scaner/CalacasScaner.txt";


void setup() {
  // List all the available serial ports
  println(Serial.list());
  // I know that the first port in the serial list on my mac
  // is always my  Keyspan adaptor, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[0], 9600);
}
void writefile(String filename, String filestring){
  FileWriter file; 
  
  try {  
     file = new FileWriter(filename, false); //bool tells to append 
     file.write(filestring); //(string, start char, end char) 
     file.close(); 
   }catch(Exception e){  
     println("Error: Can't open file!"); 
   }  
}

void draw() {
  
  while (myPort.available() > 0) {
    
    int inByte = myPort.read();
    //println(inByte);
    
    //PAISAJE
    if (inByte == 2){
      
      NoteStatus = 0;
      
      if (NoteStatus2 == 1){
         println("PAISAJE");
         //GUARDA EN ARCHIVO EL TIPO DE IMAGEN PARA QUE C# LO LEA
         writefile(Archivo, "2");
	 NoteStatus2 ++;
      }
    }
    //RETRATO
    else if(inByte == 1){
      
      NoteStatus ++;
      
      if (NoteStatus == 1){
         println("RETRATO");
         //GUARDA EN ARCHIVO EL TIPO DE IMAGEN PARA QUE C# LO LEA
         writefile(Archivo, "1");
	 NoteStatus2 = 1;
      }
     
    }
       
    //SCANEA
     if (inByte == 3){
       Scanea = 0;
      //MANDA A SCANEAR
      if (NoScanea == 1){
         println("scan");
         //EJECUTA SCRIPT PARA MANDAR CLICK
         open("C:/Users/DELL/Desktop/Cliente Scaner/click.ahk");
	 NoScanea ++;
      }
    }
 
    else if(inByte == 4){
       Scanea ++;
      //EVITA QUE SE MANDE MANDE MUCHAS VECES A SCANEAR
      if (Scanea == 1){
         NoScanea = 1;
      }
     
    }
   
    
  }
}



