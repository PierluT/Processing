import oscP5.*;
import netP5.*;
  
  
  
class OscManage{
  
  OscP5 oscP5 = new OscP5(this,8000);
  NetAddress myRemoteLocation = new NetAddress("10.169.148.156",9000);
  
  // store incoming/outgoing value
  float value;
  
  // to display sending or receiving
  String activity = "";
  
  
  float getValue(){
    return value;
  }
  String getActivity(){
    return activity;
  }
  
  
  void mouseClicked() {
    sendMessage();
  }

  void mouseDragged() {
    sendMessage();
  }

  void sendMessage() {
  
    activity = "sending: ";
  
    value = 50;
  
    OscMessage myMessage = new OscMessage("/1/juce");
    myMessage.add(value); 
    oscP5.send(myMessage, myRemoteLocation); 
  }
  
  /* incoming osc message are forwarded to the oscEvent method. */
  void oscEvent(OscMessage theOscMessage) {
  
    // only react on this addresspattern
     if(theOscMessage.checkAddrPattern("/1/juce")==true) {
     
       // check if the value is a float
       if(theOscMessage.checkTypetag("f")) {
          activity = "receiving: "; 
       
          value = theOscMessage.get(0).floatValue();
       }
    }
  }
}
