import controlP5.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
ControlP5 cp5;

float x,y,z;  //coordinates of the shape (translation)

float r,g,b; //color of the shape

PImage labyrinth;
PImage logo;
PImage bg;
int xPoint;
int yPoint;

int diam = 16;

void setup(){
  size(620, 620);
  oscP5 = new OscP5(this,7563);
  labyrinth = loadImage("labyrintho.png"); 
  bg = loadImage("Verdino.jpg");
  logo = loadImage("Animal0.png");
  xPoint = width-50;
  yPoint = height-350;
  myRemoteLocation = new NetAddress("10.168.76.204",7563);
}

void draw()
{
  background(bg);
  //background(255);
  image(labyrinth,width/2,height/2);

//se esco dal labrinto??
/*
if((x > 155) && (x < 180) && (y < 15)){
textSize(48);
textAlign(CENTER);
fill(255,0,0);
text("YOU WIN!",width/2,height/2);
}*/
  
  

  float touch_r_down = red(get(xPoint,yPoint+diam/2));
  float touch_g_down = green(get(xPoint,yPoint+diam/2));
  float touch_b_down = blue(get(xPoint,yPoint+diam/2));
  
  float touch_r_up = red(get(xPoint,yPoint-diam/2));
  float touch_g_up = green(get(xPoint,yPoint-diam/2));
  float touch_b_up = blue(get(xPoint,yPoint-diam/2));
  
  float touch_r_left = red(get(xPoint-diam/2,yPoint));
  float touch_g_left = green(get(xPoint-diam/2,yPoint));
  float touch_b_left = blue(get(xPoint-diam/2,yPoint));
  
  float touch_r_right = red(get(xPoint+diam/2,yPoint));
  float touch_g_right = green(get(xPoint+diam/2,yPoint));
  float touch_b_right = blue(get(xPoint+diam/2,yPoint));
  

  if(touch_r_up == 0 && touch_g_up == 0 && touch_b_up == 0 && (keyCode == UP)){   
    yPoint++; 
  }
  if(touch_r_down == 0 && touch_g_down == 0 && touch_b_down == 0 && (keyCode == DOWN)){   
    yPoint--; 
  }
  if(touch_r_left == 0 && touch_g_left == 0 && touch_b_left == 0 && (keyCode == LEFT)){   
    xPoint++; 
  }
  if(touch_r_right == 0 && touch_g_right == 0 && touch_b_right == 0 && (keyCode == RIGHT)){   
    xPoint--; 
  }
  
  
  imageMode(CENTER);
  image(logo,xPoint,yPoint,diam,diam);
  

  println(mouseX + "," + mouseY);
}


void keyPressed(){
if ((key == CODED) && (keyCode == UP)){
yPoint--;
} 
if ((key == CODED) && (keyCode == DOWN)){
yPoint++;
} 
if ((key == CODED) && (keyCode == RIGHT)){
xPoint++;
} 
if ((key == CODED) && (keyCode == LEFT)){
xPoint--;
}
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  
  
  
  //If address of oscMessage is /colour then change the shape and colour visualized
  if (theOscMessage.checkAddrPattern("/colour"))
  {
    
    //get rgb values
    r = theOscMessage.get(0).intValue();
    g = theOscMessage.get(1).intValue();
    b = theOscMessage.get(2).intValue();
    println(" value: r:"+r+" g:"+g+" b:"+b);
  }
  
  
  //If address of oscMessage is /distance then change the size of the shape
  if (theOscMessage.checkAddrPattern("/distance"))
  {
    
    //get distance (invert sign, assuming distance in the message is passed as a positive value)
    z = -theOscMessage.get(0).floatValue();
    println(" distance: "+z);
  }
  
  
}
