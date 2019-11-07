class Spin 
{
  float op=255;
  String InitTime;
  int InitTimerFlag = 0;
  
 
  //vector de translacion en eje Y, indica cuanto se debe de mover la imagen a cada instante
  float[] TranslacionY = new float[NumeroTotaldeImagenes];
  //vector de posicion de imagenes en eje y, resultado del procesamiento en funcion
  float[] py = new float[NumeroTotaldeImagenes];
  
  
 
  //vector de de corrida de la imagen, indica cuantas veces ha caido
  float setimgY(int IndiceImagenActual, float StartX, float StartY, int IndiceImagenInicio, int IndiceImagenFin, float Opacidad, float Velocidad) {
      
      float Posicion = 0;
     
      try{
        if(InitTimerFlag == 0){
          //
          InitTime = ("" + minute() + ":" + second() + ":" + millis());
          InitTimerFlag = 1;
        }
          
        pushMatrix();
        
         //cambia opacidad de la imagen
        tint(255,Opacidad);  
        
        //puntero que hace transladar la imagen en el eje y
        TranslacionY[IndiceImagenActual] = TranslacionY[IndiceImagenActual] + Velocidad;
        
        //establece posicion
        Posicion = - (images[IndiceImagenActual].height + StartY) + TranslacionY[IndiceImagenActual];
        
        //println("InitTime = "+ InitTime +" CurrentTime = "+minute() + ":" + second() + ":" + millis() +" Imagen [" + nf(IndiceImagenActual, 2) +"] Altura = " +images[IndiceImagenActual].height + " , Posicion = "+ nf(Posicion, 3, 2) +" , Opacidad = " + Opacidad );
      
        //si la posicion de la imagen esta fuera del rango de pantalla reinicia
        if ((Posicion >= ResolY) && (IndiceImagenActual == IndiceImagenFin)) {
          TranslacionY[IndiceImagenInicio] = 0;
          TranslacionY[IndiceImagenFin] = 0;
        }
        
        //translanda la imagen k a la posicion calculada
        image(images[IndiceImagenActual], StartX, Posicion);
        
        popMatrix();
        
      }catch (Throwable t){
      
      }
      return Posicion;
      
  }
  
  void CreaCapa(int ImagenInicio, int ImagenFin, boolean UsarFillerX, int ExtfillerX, float Opacidad, float Velocidad){
     
     int fillerX = 0;
     int fillerY = 150;
     int NumColumna = 1;
     int ContadorPares = 1;
    
     for(int i = ImagenInicio; i <= ImagenFin; i++) {
        
         //si el numero de columna es 1 posiciona la imagen en el valor de inicio
         if (UsarFillerX == false){
           if(NumColumna == 1){
             fillerX = InicioXpix;
           }else{//si el numero ed columna es mayor a uno
             //para el contador de pares con valor uno obtienela nueva posicion en x
             if(ContadorPares == 1){
               fillerX = fillerX + TMImgXpix + EspaciadorXpix;
             }
             //para contador diferente de 1 posiciona la imagen en x en el valor anteriormente calculado para 1
             else{
               fillerX = fillerX;
             }
           }
         }
         else {
           if(NumColumna == 1){
             fillerX = ExtfillerX;
           }else{//si el numero ed columna es mayor a uno
             //para el contador de pares con valor uno obtienela nueva posicion en x
             if(ContadorPares == 1){
               fillerX = fillerX + TMImgXpix + EspaciadorXpix;
             }
             //para contador diferente de 1 posiciona la imagen en x en el valor anteriormente calculado para 1
             else{
               fillerX = fillerX;
             }
           }
         }
        
        //imagen 1 columna NumColumna
        if(ContadorPares == 1){
          py[i]   = setimgY(i, fillerX, 0, i, (i+1), Opacidad, Velocidad);
          ContadorPares ++; //aumenta el contador de pares
        //imagen 2 columna NumColumna  
        }else if(ContadorPares == 2){
          py[i] = setimgY(i, fillerX, images[i-1].height + fillerY, (i-1), i, Opacidad, Velocidad);
          ContadorPares =1; //reinicia el contador
          NumColumna++;     //pasa a la siguiente columna
          //println("Distancia entre ["+ (i-1) +"] y [" + i +"] = "+ abs(py[i]-py[i-1])  );
        }
        
      }
  
  
  }
  
  
    
  void display() {
      
      noStroke();
    
    
    //capa 7
      CreaCapa(140, 149, true, 5, 75, .8);
       
      //capa 6
      CreaCapa(130, 139, true, 120, 20, .7);
      
      //capa 5
      CreaCapa(120, 129, true, 90, 70, .6);
    
      //capa 4
      CreaCapa(110, 119, true, 80, 150, .5);
    
      //capa 3
      CreaCapa(100, 109, true, 60, 120, .4);
      
      //capa 2
      CreaCapa(90, 99, true, 50, 210, .3);
     
      //capa 1
      CreaCapa(80, 89, false, 30, 200, .2);
     
     
      
      //------
    
      //capa 8
      CreaCapa(70, 79, true, 40, 65, .1);
       
      //capa 7
      CreaCapa(60, 69, true, 65, 80, .2);
       
      //capa 6
      CreaCapa(50, 59, true, 110, 100, .3);
      
      //capa 5
      CreaCapa(40, 49, true, 20, 130, .4);
    
      //capa 4
      CreaCapa(30, 39, true, 70, 160, .5);
    
      //capa 3
      CreaCapa(20, 29, true, 100, 190, .6);
      
      //capa 2
      CreaCapa(10, 19, true, 10, 220, .7);
     
      //capa 1
      CreaCapa(0, 9, false, 0, 255, 1);
      
      
      
      
      
      pushMatrix();
       
      //translanda la imagen k a la posicion calculada
      image(Marco, 0, 0);
        
      popMatrix();

      
  }

  
 
}
