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

//ANDREW
boolean boomAndrew = false;
PImage andrew;
float xAndrew = 20;
float yAndrew = 523;

//CLAUDIO
boolean boomClaudio = false;
PImage claudio;
float xClaudio = 300;
float yClaudio = 523;

//PIER
boolean boomPier = false;
PImage pier;
float xPier = 200;
float yPier = 523;

//RICKY
boolean boomRicky = false;
PImage ricky;
float xRicky =100;
float yRicky = 523;

//CHICK
boolean boomC = false;
PImage chick;
float xChick = 230;
float yChick = 400;

//PIG
boolean boomP = false;
PImage pig;
float xPig = 500;
float yPig = 600;


float xPoint;
float yPoint;
float xVel = 5;
float yVel = 5;

float diamCapr = 50;
float diam = 30;

void setup(){
  size(800, 800);

  oscP5 = new OscP5(this,7563);
  labyrinth = loadImage("maze.png"); 
  bg = loadImage("Verdino.jpg");
  
  logo = loadImage("Animal0.png");
  chick = loadImage("Animal1.png");
  pig = loadImage("Animal2.png");
  andrew = loadImage("AndrewSad.png");
  claudio = loadImage("ClaudioSad.jpeg");
  pier = loadImage("PierSad.jpeg");
  ricky = loadImage("RickySad.jpeg");
  
  xPoint = width/2;
  yPoint = height/2;
  myRemoteLocation = new NetAddress("192.168.6.2",7563);
}

void draw()
{
  background(bg);
  //background(255);
  image(labyrinth,width/2,height/2);
  
  if(boomAndrew == false){
    image(andrew,xAndrew,yAndrew,diam,diam);
  }
  if(boomClaudio == false){
    image(claudio,xClaudio,yClaudio,diam,diam);
  }
  if(boomPier == false){
    image(pier,xPier,yPier,diam,diam);
  }
  if(boomRicky == false){
    image(ricky,xRicky,yRicky,diam,diam);
  }
  if(boomC == false){
    image(chick,xChick,yChick,diam,diam);
  }
  if(boomP == false){
    image(pig,xPig,yPig,diam,diam);
  }
  
  

  float touch_r_down = red(get((int)xPoint, (int)(yPoint+diamCapr/2)));
  float touch_g_down = green(get((int)xPoint,(int)(yPoint+diamCapr/2)));
  float touch_b_down = blue(get((int)xPoint,(int)(yPoint+diamCapr/2)));
  
  float touch_r_up = red(get((int)xPoint,(int)(yPoint-diamCapr/2)));
  float touch_g_up = green(get((int)xPoint,(int)(yPoint-diamCapr/2)));
  float touch_b_up = blue(get((int)xPoint,(int)(yPoint-diamCapr/2)));
  
  float touch_r_left = red(get((int)(xPoint-diamCapr/2),(int)yPoint));
  float touch_g_left = green(get((int)(xPoint-diamCapr/2),(int)yPoint));
  float touch_b_left = blue(get((int)(xPoint-diamCapr/2),(int)yPoint));
  
  float touch_r_right = red(get((int)(xPoint+diamCapr/2),(int)yPoint));
  float touch_g_right = green(get((int)(xPoint+diamCapr/2),(int)yPoint));
  float touch_b_right = blue(get((int)(xPoint+diamCapr/2),(int)yPoint));
  

  if(touch_r_up == 0 && touch_g_up == 0 && touch_b_up == 0 && (keyCode == UP)){   
    yPoint++; 
    if(key==CODED){
      yPoint = yPoint + yVel;
    }
  }
  if(touch_r_down == 0 && touch_g_down == 0 && touch_b_down == 0 && (keyCode == DOWN)){   
    yPoint--; 
    if(key==CODED){
      yPoint = yPoint - yVel;
    }
  }
  if(touch_r_left == 0 && touch_g_left == 0 && touch_b_left == 0 && (keyCode == LEFT)){   
    xPoint++; 
    if(key==CODED){
      xPoint = xPoint + xVel;
    }
  }
  if(touch_r_right == 0 && touch_g_right == 0 && touch_b_right == 0 && (keyCode == RIGHT)){   
    xPoint--; 
    if(key==CODED){
      xPoint = xPoint - xVel;
    }
  }
  
  
  imageMode(CENTER);
  image(logo,xPoint,yPoint,diamCapr,diamCapr);
  

  if(xPoint >= xAndrew - (diam/2 + diamCapr/2) && xPoint <= xAndrew + (diam/2 + diamCapr/2)
  && yPoint >= yAndrew - (diam/2 + diamCapr/2) && yPoint <= yAndrew + (diam/2 + diamCapr/2)
  && boomAndrew == false){
    imageMode(CENTER);
    image(logo,width/2,height/2,diamCapr,diamCapr);
    xPoint = width/2;
    yPoint = height/2;
  }
  if(xPoint >= xAndrew - (diam+diamCapr) && xPoint <= xAndrew + (diam+diamCapr)
  && yPoint >= yAndrew - (diam+diamCapr) && yPoint <= yAndrew + (diam+diamCapr)
  && mouseButton == LEFT){
    boomAndrew = true;
    mouseButton = 0;
  }
  
  if(xPoint >= xClaudio - (diam/2 + diamCapr/2) && xPoint <= xClaudio + (diam/2 + diamCapr/2)
  && yPoint >= yClaudio - (diam/2 + diamCapr/2) && yPoint <= yClaudio + (diam/2 + diamCapr/2)
  && boomClaudio == false){
    imageMode(CENTER);
    image(logo,width/2,height/2,diamCapr,diamCapr);
    xPoint = width/2;
    yPoint = height/2;
  }
  if(xPoint >= xClaudio - (diam+diamCapr) && xPoint <= xClaudio + (diam+diamCapr)
  && yPoint >= yClaudio - (diam+diamCapr) && yPoint <= yClaudio + (diam+diamCapr)
  && mouseButton == LEFT){
    boomClaudio = true;
    mouseButton = 0;
  }

  if(xPoint >= xPier - (diam/2 + diamCapr/2) && xPoint <= xPier + (diam/2 + diamCapr/2)
  && yPoint >= yPier - (diam/2 + diamCapr/2) && yPoint <= yPier + (diam/2 + diamCapr/2)
  && boomPier == false){
    imageMode(CENTER);
    image(logo,width/2,height/2,diamCapr,diamCapr);
    xPoint = width/2;
    yPoint = height/2;
  }
  if(xPoint >= xPier - (diam+diamCapr) && xPoint <= xPier + (diam+diamCapr)
  && yPoint >= yPier - (diam+diamCapr) && yPoint <= yPier + (diam+diamCapr)
  && mouseButton == LEFT){
    boomPier = true;
    mouseButton = 0;
  }
  
  if(xPoint >= xRicky - (diam/2 + diamCapr/2) && xPoint <= xRicky + (diam/2 + diamCapr/2)
  && yPoint >= yRicky - (diam/2 + diamCapr/2) && yPoint <= yRicky + (diam/2 + diamCapr/2)
  && boomRicky == false){
    imageMode(CENTER);
    image(logo,width/2,height/2,diamCapr,diamCapr);
    xPoint = width/2;
    yPoint = height/2;
  }
  if(xPoint >= xRicky - (diam+diamCapr) && xPoint <= xRicky + (diam+diamCapr)
  && yPoint >= yRicky - (diam+diamCapr) && yPoint <= yRicky + (diam+diamCapr)
  && mouseButton == LEFT){
    boomRicky = true;
    mouseButton = 0;
  }
  

  //CHICKEN
  if(xPoint >= xChick - (diam/2 + diamCapr/2) && xPoint <= xChick + (diam/2 + diamCapr/2)
  && yPoint >= yChick - (diam/2 + diamCapr/2) && yPoint <= yChick + (diam/2 + diamCapr/2)
  && boomC == false){
    imageMode(CENTER);
    image(logo,width/2,height/2,diamCapr,diamCapr);
    xPoint = width/2;
    yPoint = height/2;
  }
  if(xPoint >= xChick - (diam+diamCapr) && xPoint <= xChick + (diam+diamCapr)
  && yPoint >= yChick - (diam+diamCapr) && yPoint <= yChick + (diam+diamCapr)
  && mouseButton == LEFT){
    boomC = true;
    mouseButton = 0;
  }
  
  //PIG
  if(xPoint >= xPig - (diam/2 + diamCapr/2) && xPoint <= xPig + (diam/2 + diamCapr/2)
  && yPoint >= yPig - (diam/2 + diamCapr/2) && yPoint <= yPig + (diam/2 + diamCapr/2)
  && boomP == false){
    imageMode(CENTER);
    image(logo,width/2,height/2,diamCapr,diamCapr);
    xPoint = width/2;
    yPoint = height/2;
  }
  if(xPoint >= xPig - (diam+diamCapr) && xPoint <= xPig + (diam+diamCapr)
  && yPoint >= yPig - (diam+diamCapr) && yPoint <= yPig + (diam+diamCapr)
  && mouseButton == LEFT){
    boomP = true;
    mouseButton = 0;
  }
  

  //println(mouseX + "," + mouseY);
}


void keyPressed(){
if ((key == CODED) && (keyCode == UP)){
yPoint = yPoint - yVel;
} 
if ((key == CODED) && (keyCode == DOWN)){
yPoint = yPoint + yVel;
} 
if ((key == CODED) && (keyCode == RIGHT)){
//if (r > -0.176){
  xPoint = xPoint + xVel;
} 
if ((key == CODED) && (keyCode == LEFT)){
xPoint = xPoint - xVel;
}
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  //If address of oscMessage is /colour then change the shape and colour visualized
  if (theOscMessage.checkAddrPattern("/movement"))
  {
    
    //Get X value
    x = theOscMessage.get(0).floatValue();
    if (Math.round(x) == -1){
      xPoint = xPoint - xVel;//move to right
    }
    if(Math.round(x) == 1) {
    xPoint = xPoint + xVel;//move to left
    }
    
    println(" value: y:"+Math.round(y));
    //Get Y value
    y = theOscMessage.get(1).floatValue();
    if (Math.round(y) == 1){
      yPoint = yPoint - yVel;//move up
    }
    if(Math.round(y) == -1) {
    yPoint = yPoint + yVel;//move down
    }
    println(" value: y:"+Math.round(y));
    //b = theOscMessage.get(2).floatValue();
    
  }
  
  
  //If address of oscMessage is /distance then change the size of the shape
  if (theOscMessage.checkAddrPattern("/distance"))
  {
    
    //get distance (invert sign, assuming distance in the message is passed as a positive value)
    z = -theOscMessage.get(0).floatValue();
    println(" distance: "+z);
  }
  
  
}

void oscMovementRecieved(){
if (r > 0){
xPoint = xPoint - xVel;
} else if(r < 0){
xPoint = xPoint + xVel;
}

}
