public class Time implements Cloneable{

private long t;

 public Time(){
  this.t=System.currentTimeMillis();
 }

 public int millis(){
  return (int)(System.currentTimeMillis() - this.t);
 }

 public void resetTime(){
  this.t=System.currentTimeMillis();
 }

 public Object clone(){
    try
       {
       return super.clone();
       }
    catch ( CloneNotSupportedException e )
       {
       return null;
       }
     }
}
