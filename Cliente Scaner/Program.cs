using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Threading;
using System.IO;
using System.Configuration;

namespace OSCBridge
{


    class Program
    {
     
        static OSC.NET.OSCReceiver receiver = null;
		static OSC.NET.OSCTransmitter transmitter = null;
		static Thread listenerThread = null;

        static string ListenPort = "";           //ip del host OSC
        static string ListenAddress = "";        //puerto del host OSC
        static string FileToRead = "";           //archivo donde se le el tipo de imagen
        static string LocalImageFolder = "";     //carpeta local se encuentra las imagenes a copiar
        static string RemoteImageFolder = "";    //carpeta remota a donde se copian las imagenes
        static string ImageKind = "";            //tipo de imagen recuperado del archivo FileToRead

        static string ReadFiletoRead () {
            string text = System.IO.File.ReadAllText(@"" + FileToRead);
            return text;
        }

        static void Main(string[] args){

            try
            {
                //obtiene valores de los parametros de configuracion
                ListenPort = ConfigurationSettings.AppSettings["ListenPort"];
                ListenAddress = ConfigurationSettings.AppSettings["ListenAddress"];
                FileToRead = ConfigurationSettings.AppSettings["FileToRead"];
                LocalImageFolder = ConfigurationSettings.AppSettings["LocalImageFolder"];
                RemoteImageFolder = ConfigurationSettings.AppSettings["RemoteImageFolder"];
                ImageKind = ReadFiletoRead();
                
                Console.WriteLine("ListenPort = " + ListenPort);
                Console.WriteLine("ListenAddress = " + ListenAddress);
                Console.WriteLine("FileToRead = " + FileToRead);
                Console.WriteLine("ImageFolder = " + LocalImageFolder);
                Console.WriteLine("RemoteImageFolder = " + RemoteImageFolder);
                Console.WriteLine("ImageKind = " + ImageKind);
                //Console.Read();

                 //si todos los parametros necesarios para inicializar el programa existen
                if (ListenPort.Length > 0 && ListenPort.Length > 0 && ListenPort.Length > 0 && LocalImageFolder.Length > 0 && RemoteImageFolder.Length > 0 && ImageKind.Length > 0)
                {
                    Console.WriteLine("conectando al servidor OSC");
                    OSCConnect();
                    ProcessDir(LocalImageFolder, RemoteImageFolder);
                    OSCDisconnect();
                    //Console.ReadKey();
                    Console.WriteLine("desconectando del servidor OSC");
                    Environment.Exit(0);
                   
                }
                else//si alguno de los parametros esta vacio
                {
                    Console.WriteLine("Error falta algun parametro de inicio en archivo app.config");
                    Console.Read();
                }

            }
            catch (Exception ex)//si existe algun error
            {
                Console.WriteLine("Error " + ex.ToString());
                Console.Read();
            }

        }

        static void OSCConnect()
        {
            //inicializa cliente OSC en puerto e ip remota
            transmitter = new OSC.NET.OSCTransmitter(ListenAddress, int.Parse(ListenPort));
            
            //server local osc
            //receiver = new OSC.NET.OSCReceiver(int.Parse("12001"));
            //listenerThread = new Thread(new ThreadStart(receive));
            //listenerThread.Start();
        }

        static void OSCDisconnect()
        {
            if (transmitter != null) transmitter.Close();
            if (receiver != null) receiver.Close();
            if (listenerThread != null) listenerThread.Abort();
            listenerThread = null;
            receiver = null;
            transmitter = null;
        }
        static void send(string TagName, string ImageName, string ImageType)
        {
            OSC.NET.OSCMessage msg = new OSC.NET.OSCMessage("/" + TagName);
            msg.Append(ImageName);
            msg.Append(ImageType);
            transmitter.Send(msg);
        }

        static void receive()
        {
            while (true)
            {
                OSC.NET.OSCPacket msg = receiver.Receive();
                Console.WriteLine(msg.Address);
                ArrayList objs = msg.Values;
                string data = "";
                bool first = true;
                foreach (object obj in objs)
                {
                    if (first) first = false;
                    else data += ",";
                    data += obj.ToString();
                }
             
                Console.WriteLine(data);
            }
        }
        
        static  void ProcessDir(string sourceDir, string CopyDir)
        {
            String result;

            string[] fileEntries = Directory.GetFiles(sourceDir,"*.jpg");
            foreach (string fileName in fileEntries)
            {
              
                try
                {
                    // do something with fileName
                    result = Path.GetFileName(fileName);

                    //si el archivo ya existe en el servidor remoto
                    if (File.Exists(CopyDir + result)){
                        //Console.WriteLine(result +" ya existe en " + CopyDir);                        
                    }
                    else{ //si el archivo no existe en el server remoto
                    
                        //copia archivo a carpeta remota
                        File.Copy(sourceDir + "/" + result, CopyDir + result);
                        //envia trama OSC a server remoto
                        //comando SendImage , nombre de imagen, tipo de imagen
                        send("SendImage", result, ImageKind);
                        Console.WriteLine(result + " fue copiado en " + CopyDir);
                    }
                    
                }
                catch (Exception e)
                {
                    Console.WriteLine("The process failed: {0}", e.ToString());
                    send("SendImage", "peper","caca");
                }
            }
        }
    }
}
