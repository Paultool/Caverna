
public class Osc
{
    //OSC
  OscP5 oscP5;
  NetAddress myRemoteLocation;
  
  
  public void StartListener(int OSCListenPort){
     //OSC 
     /*inicio en escucha de mensajes entrantes en puerto 12000 */
     oscP5 = new OscP5(this,OSCListenPort); 
  }

  //osc parser
  void oscEvent(OscMessage theOscMessage) {
    
    // si el server osc recibe el tag /SendImage entonces parsea parametros 
    // el mensaje osc recibe dos parametros ImageName, ImageType
    if(theOscMessage.checkAddrPattern("/SendImage")==true) {
      
      // 1er parametro contiene el nombre de la imagen recibida
      String ImageName = theOscMessage.get(0).stringValue();
      
      // 2do parametro contiene el identificador de tipo de imagen valores (retrato=1, otro=2)
      // dependiendo de este parametro se ubicara la imagen en (otro=primeros planos, retrato=ultimos planos)
      String ImageType = theOscMessage.get(1).stringValue();
      
      // carga la imagen recibida en el plano 
      //a = loadImage("/images/"+firstValue); 
      println("Receive ImageName: "+ ImageName +" ImageType: "+ ImageType+" B = "+ImageType.length());
      
      //intenta cargar imagenes en array correspondiente
      try{
        
        
        //todas en capas 1 y 2, 3
        if(Integer.parseInt(ImageType) <= 2) {
          println("Raetrato Receive ImageName: "+ ImageName +" ImageType: "+ ImageType +" ConRetrato = " + ConRetrato);
          images[ConRetrato]=loadImage("Imagenes/" + ImageName); 
         
          //capa 1
          if(ConRetrato<=10){
           images[ConRetrato].resize(TMImgXpix - 30, 0); 
           ConRetrato++;
          }
          
          //capa2
          else if(ConRetrato >10 && ConRetrato <= 20){
           
           images[ConRetrato].resize(TMImgXpix - 40, 0); 
           ConRetrato++;
          }
          
          //capa 3
          else if(ConRetrato >20 && ConRetrato <= 30){
           
           images[ConRetrato].resize(TMImgXpix - 50, 0); 
           
           //si el contador llega a 30 reinicia la pila
           if(ConRetrato == 30){
            ConRetrato = 0;
           }else{
             ConRetrato++;
           }
          
          }
          
        }
        
        
        //paisaje en capas 3 y 4
        else if(Integer.parseInt(ImageType) == 3){
          println("Paisaje Receive ImageName: "+ ImageName +" ImageType: "+ ImageType +" ConPaisaje = " + ConPaisaje);
          images[ConPaisaje]=loadImage("Imagenes/" + ImageName); 
          
           //capa 3
          if(ConPaisaje<=10){
            images[ConPaisaje].resize(TMImgXpix - 90, 0); 
            ConPaisaje++;
          }
          
           //capa 4
          else if(ConPaisaje >10 && ConPaisaje <= 20){
            
             images[ConPaisaje].resize(TMImgXpix - 100, 0);
           
             //si el contador llega a 20 reinicia la pila
             if(ConPaisaje == 20){
              ConPaisaje = 0;
             }else{
               ConPaisaje++;
             } 
         
          }
          
        }
      } catch (Throwable t){
      
      }
      
      
      
      
      
      
      return;
    } 
    println("### received an osc message. with address pattern "+theOscMessage.addrPattern());
  }

}
