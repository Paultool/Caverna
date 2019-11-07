import oscP5.*;
import netP5.*;
import fullscreen.*; 


//ARREGLO DE IMAGES
int NumeroTotaldeImagenes = 154; //de las variables mas importantes con esta se dimensionan los arreglos
Spin spots;
PImage[] images;
PImage Marco;

//FULL SCREEN    

FullScreen fs;

//VARIABLES RESOLUCION
//RESOLUCION DEL MONITOR
// 1440x900 Pixels
//RESOLUCION DEL PROYECTOR
// Sanyo PLC-XF46N 
// RESOLUCION NATIVA 1024x768 Pixels
// MAXIMA RESOLUCION 1600x1200 Pixels
int ResolX = 1920; //ANCHO CAMBIAR AQUIVALORES
int ResolY = 1080;  //LARGO CAMBIAR AQUI VALORES 864

//DIMENSION DE LA PROYECCION AQUI SE SITUAN LAS VARIABLES
//DE LAS DIMENSIONES DE LA SUPERFICIE EN CM.
float ProX = 227;//400 CM = 4MTS ANCHO
float ProY = 167;//240 CM = 2.4MTS LARGO

//PPP CON QUE FUERON SCANEADAS LAS IMAGENES
float PPP = 150;

//PIXELES POR CENTIMETRO
float PPcmX = ResolX/ProX; //ANCHO
float PPcmY = ResolY/ProY; //LARGO

//TAMANIO DE PROYECCION MAXIMO DE LA IMAGEN DEL PRIMER PLANO EN CM.
float TMImgXcm = 32; //ANCHO
float TMImgYcm = 32; //LARGO

//TAMANIO DE PROYECCION MAXIMO DE LA IMAGEN DEL PRIMER PLANO EN PIXELES.
int TMImgXpix = int (PPcmX * TMImgXcm); //ANCHO
int TMImgYpix = int (PPcmY * TMImgYcm); //LARGO

//LONGUITUD DEL ESPACIOADOR DE IMAGENES DEL PRIMER PLANO, PONER VALOR EN CM (15 = 15 cm)
int EspaciadorXpix = int (15 * PPcmX); 

//POSICION DE INICIO DE LA PRIMER HILERA DE IMAGENES EN EJE X, PONER VALOR EN CM (15 = 15 cm)
int InicioXpix = int (5 * PPcmX); 

Osc OscServer;

//CONTADORES DE IMAGENES SCANEADAS
int ConRetrato = 0;
int ConPaisaje = 1; 


void setup() 
{
  //SE SETEA RESOLUCION DEL APPLET
  size(1920, 1080);
  smooth();
  frameRate(1);
  LoadImages(NumeroTotaldeImagenes,"IMG_", 0);
  spots = new Spin();
 
  //Create the fullscreen object
  //fs = new FullScreen(this); 
  //enter fullscreen mode
  //fs.enter();
  
  //OscServer = new Osc();
  //OscServer.StartListener(12000);

  
}

void LoadImages(int ImageArrayLenght, String ImagePrefix, float s){
  
  //marco
  Marco = loadImage("marco.png");
  Marco.resize(ResolX,ResolY);
  image(Marco,0,0);
  
  
  //dimensiona arreglo de imagens
  images = new PImage[0];
  images = new PImage[ImageArrayLenght];
    
  //carga en memoria un lote de imagenes de la primer capa
  for(int i = 0; i < 10; i++) {
    //carga imagen en memoria
    images[i]  = loadImage("Imagenes/" + ImagePrefix + nf(i, 4) + "." + "jpg");
    //redimensiona el ancho de la imagen a su valor maximo en pixeles    
    images[i].resize(TMImgXpix, 0); 
    println("Carga imagen ["+i+"] = "+ ImagePrefix + nf(i, 4) + "." + "jpg");
  }
  
  
  int j=10;
  //imagenes de segunda capa en este caso recicle las imagenes del 0 al 9
  //solamente hay que quitar el contador j y replazarlo por i
  for(int i = 10; i < 20; i++) {
    //carga imagen en memoria
     images[i]  = loadImage("Imagenes/" + ImagePrefix + nf(j, 4) + "." + "jpg");
    //redimensiona el ancho de la imagen a su valor maximo en pixeles    
    images[i].resize(TMImgXpix - 30, 0);
    println("Carga imagen ["+i+"] = "+ ImagePrefix + nf(j, 4) + "." + "jpg");
    j++;
  }
  
   j=20;
  //imagenes de tercer capa en este caso recicle las imagenes del 0 al 9
  //solamente hay que quitar el contador j y replazarlo por i
  for(int i = 20; i < 30; i++) {
    //carga imagen en memoria
    images[i]  = loadImage("Imagenes/" + ImagePrefix + nf(j, 4) + "." + "jpg");
    //redimensiona el ancho de la imagen a su valor maximo en pixeles    
    images[i].resize(TMImgXpix - 40, 0);
    println("Carga imagen ["+i+"] = "+ ImagePrefix + nf(j, 4) + "." + "jpg");
    j++;
  }
  
  
   j=30;
  //imagenes de tercer capa en este caso recicle las imagenes del 0 al 9
  //solamente hay que quitar el contador j y replazarlo por i
  for(int i = 30; i < 40; i++) {
    //carga imagen en memoria
     images[i]  = loadImage("Imagenes/" + ImagePrefix + nf(j, 4) + "." + "jpg");
    //redimensiona el ancho de la imagen a su valor maximo en pixeles    
    images[i].resize(TMImgXpix - 50, 0);
    println("Carga imagen ["+i+"] = "+ ImagePrefix + nf(j, 4) + "." + "jpg");
    j++;
  }
  
    j=40;
  //imagenes de tercer capa en este caso recicle las imagenes del 0 al 9
  //solamente hay que quitar el contador j y replazarlo por i
  for(int i = 40; i < 50; i++) {
    //carga imagen en memoria
     images[i]  = loadImage("Imagenes/" + ImagePrefix + nf(j, 4) + "." + "jpg");
    //redimensiona el ancho de la imagen a su valor maximo en pixeles    
    images[i].resize(TMImgXpix - 60, 0);
    println("Carga imagen ["+i+"] = "+ ImagePrefix + nf(j, 4) + "." + "jpg");
    j++;
  }
  
  
  j=50;
  //imagenes de tercer capa en este caso recicle las imagenes del 0 al 9
  //solamente hay que quitar el contador j y replazarlo por i
  for(int i = 50; i < 60; i++) {
    //carga imagen en memoria
     images[i]  = loadImage("Imagenes/" + ImagePrefix + nf(j, 4) + "." + "jpg");
    //redimensiona el ancho de la imagen a su valor maximo en pixeles    
    images[i].resize(TMImgXpix - 70, 0);
    println("Carga imagen ["+i+"] = "+ ImagePrefix + nf(j, 4) + "." + "jpg");
    j++;
  }
  
  
  j=60;
  //imagenes de segunda capa en este caso recicle las imagenes del 0 al 9
  //solamente hay que quitar el contador j y replazarlo por i
  for(int i = 60; i < 70; i++) {
    //carga imagen en memoria
     images[i]  = loadImage("Imagenes/" + ImagePrefix + nf(j, 4) + "." + "jpg");
    //redimensiona el ancho de la imagen a su valor maximo en pixeles    
    images[i].resize(TMImgXpix - 80, 0);
    println("Carga imagen ["+i+"] = "+ ImagePrefix + nf(j, 4) + "." + "jpg");
    j++;
  }
  
  j=70;
  //imagenes de tercer capa en este caso recicle las imagenes del 0 al 9
  //solamente hay que quitar el contador j y replazarlo por i
  for(int i = 70; i < 80; i++) {
    //carga imagen en memoria
     images[i]  = loadImage("Imagenes/" + ImagePrefix + nf(j, 4) + "." + "jpg");
    //redimensiona el ancho de la imagen a su valor maximo en pixeles    
    images[i].resize(TMImgXpix - 90, 0);
    println("Carga imagen ["+i+"] = "+ ImagePrefix + nf(j, 4) + "." + "jpg");
    j++;
  }
  
   j=80;
  //imagenes de tercer capa en este caso recicle las imagenes del 0 al 9
  //solamente hay que quitar el contador j y replazarlo por i
  for(int i = 80; i < 90; i++) {
    //carga imagen en memoria
     images[i]  = loadImage("Imagenes/" + ImagePrefix + nf(j, 4) + "." + "jpg");
    //redimensiona el ancho de la imagen a su valor maximo en pixeles    
    images[i].resize(TMImgXpix - 100, 0);
    println("Carga imagen ["+i+"] = "+ ImagePrefix + nf(j, 4) + "." + "jpg");
    j++;
  }
  
   j=90;
  //imagenes de tercer capa en este caso recicle las imagenes del 0 al 9
  //solamente hay que quitar el contador j y replazarlo por i
  for(int i = 90; i < 100; i++) {
    //carga imagen en memoria
     images[i]  = loadImage("Imagenes/" + ImagePrefix + nf(j, 4) + "." + "jpg");
    //redimensiona el ancho de la imagen a su valor maximo en pixeles    
    images[i].resize(TMImgXpix - 110, 0);
    println("Carga imagen ["+i+"] = "+ ImagePrefix + nf(j, 4) + "." + "jpg");
    j++;
   }
    
   j=100;
  //imagenes de tercer capa en este caso recicle las imagenes del 0 al 9
  //solamente hay que quitar el contador j y replazarlo por i
  for(int i = 100; i < 110; i++) {
    //carga imagen en memoria
     images[i]  = loadImage("Imagenes/" + ImagePrefix + nf(j, 4) + "." + "jpg");
    //redimensiona el ancho de la imagen a su valor maximo en pixeles    
    images[i].resize(TMImgXpix - 120, 0);
    println("Carga imagen ["+i+"] = "+ ImagePrefix + nf(j, 4) + "." + "jpg");
    j++;
  }
  
   j=110;
  //imagenes de tercer capa en este caso recicle las imagenes del 0 al 9
  //solamente hay que quitar el contador j y replazarlo por i
  for(int i = 110; i < 120; i++) {
    //carga imagen en memoria
     images[i]  = loadImage("Imagenes/" + ImagePrefix + nf(j, 4) + "." + "jpg");
    //redimensiona el ancho de la imagen a su valor maximo en pixeles    
    images[i].resize(TMImgXpix - 130, 0);
    println("Carga imagen ["+i+"] = "+ ImagePrefix + nf(j, 4) + "." + "jpg");
    j++;
  }
  
     j=120;
  //imagenes de tercer capa en este caso recicle las imagenes del 0 al 9
  //solamente hay que quitar el contador j y replazarlo por i
  for(int i = 120; i < 130; i++) {
    //carga imagen en memoria
     images[i]  = loadImage("Imagenes/" + ImagePrefix + nf(j, 4) + "." + "jpg");
    //redimensiona el ancho de la imagen a su valor maximo en pixeles    
    images[i].resize(TMImgXpix - 140, 0);
    println("Carga imagen ["+i+"] = "+ ImagePrefix + nf(j, 4) + "." + "jpg");
    j++;
  }
  
  j=130;
  //imagenes de tercer capa en este caso recicle las imagenes del 0 al 9
  //solamente hay que quitar el contador j y replazarlo por i
  for(int i = 130; i < 140; i++) {
    //carga imagen en memoria
     images[i]  = loadImage("Imagenes/" + ImagePrefix + nf(j, 4) + "." + "jpg");
    //redimensiona el ancho de la imagen a su valor maximo en pixeles    
    images[i].resize(TMImgXpix - 150, 0);
    println("Carga imagen ["+i+"] = "+ ImagePrefix + nf(j, 4) + "." + "jpg");
    j++;
  }
  
    j=140;
  //imagenes de tercer capa en este caso recicle las imagenes del 0 al 9
  //solamente hay que quitar el contador j y replazarlo por i
  for(int i = 140; i < 150; i++) {
    //carga imagen en memoria
     images[i]  = loadImage("Imagenes/" + ImagePrefix + nf(j, 4) + "." + "jpg");
    //redimensiona el ancho de la imagen a su valor maximo en pixeles    
    images[i].resize(TMImgXpix - 160, 0);
    println("Carga imagen ["+i+"] = "+ ImagePrefix + nf(j, 4) + "." + "jpg");
    j++;
  }
  
}


void draw() 
{
  background(0);
  spots.display();
  saveFrame("video/caverna_#####.png");
}
