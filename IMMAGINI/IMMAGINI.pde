import oscP5.*;
import netP5.*;

PImage bg;
PImage[] animals = new PImage[4];
Bubble[] bubbles = new Bubble[4];
PImage logo;
float diam = 100;
float diam0 = 120;

// store incoming/outgoing value
float value;

// to display sending or receiving
String activity = ""; 

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(800,529);
  bg = loadImage("Grass.jpg");
  oscP5 = new OscP5(this,8000);
  myRemoteLocation = new NetAddress("10.168.72.172",9000);
  
  animals[0] = loadImage("Animal0.png");
  bubbles[0] = new Bubble(animals[0], width/2, height/2, diam0);
  
  for (int i=1; i<animals.length; i++){
    animals[i]= loadImage("Animal"+i+".png");
  }
  
  for (int i=1; i<bubbles.length; i++){
    int index = int(random(1, animals.length));
    bubbles[i] = new Bubble(animals[index],random(0+diam/2,width-diam/2),random(0+diam/2,height-diam/2),diam);
  }

}

void draw(){
  background(bg);
  fill(0);
  rect(width-diam*2,0,diam*2,diam*2);
  fill(255);
  rect(width-diam,0,diam,diam);

  
 for (int i=1; i<bubbles.length; i++){
    bubbles[i].display();
  }
  
  
  for(int i=1; i<bubbles.length; i++){
    if (mousePressed && (mouseButton == LEFT)){
      if((pmouseX <= bubbles[i].x+diam/2 && pmouseX >= bubbles[i].x-diam) && (pmouseY >= bubbles[i].y-diam/2 && pmouseY <= bubbles[i].y+diam)){
        bubbles[i].ascend(bubbles[i].x, bubbles[i].y);
        bubbles[i].top();
        bubbles[i].right();
        if(bubbles[i].x==width-diam/2 && bubbles[i].y==diam/2){
          int index = int(random(1, animals.length));
          bubbles[i] = new Bubble(animals[index],random(0+diam/2,width-diam/2),random(0+diam/2,height-diam/2),diam);
          bubbles[i].display();
        }
      }
    }
  }
  
  bubbles[0].display();
  bubbles[0].x = mouseX;
  bubbles[0].y = mouseY;
  bubbles[0].bottom();
  bubbles[0].top();
  bubbles[0].left();
  bubbles[0].right();
  
  value = 50;
  //OSC
  OscMessage myMessage = new OscMessage("/1/juce");
  myMessage.add(value); 
  oscP5.send(myMessage, myRemoteLocation); 
}


  //oscManage.oscEvent(massageToSend);

/*void mousePressed(){
    bubbles[1].ascend();
    bubbles[1].top();
    bubbles[1].right();
    if(bubbles[1].x==width-diam/2 && bubbles[1].y==diam/2){
      int index = int(random(1, animals.length));
      bubbles[1] = new Bubble(animals[index],random(0+diam/2,width-diam/2),random(0+diam/2,height-diam/2),diam);
      bubbles[1].display();
    }
  }*/
