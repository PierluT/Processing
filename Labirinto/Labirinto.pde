import controlP5.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
ControlP5 cp5;

float x,y,z,d;  //coordinates of the shape (translation)

PImage[] labyrinths = new PImage[3];
PImage labyrinthsToDraw;

/*PImage [] people = new PImage[4];
PImage presetPeople;
boolean boomPeople = false;
float xPeople = 100;
float yPeople = 100;*/

PImage logo;
PImage bg;


//CHICK
boolean boomC = false;
PImage chick;
float xChick = random(0,800);
float yChick = random(0,800);

//PIG
boolean boomP = false;
PImage pig;
float xPig = random(0,800);
float yPig = random(0,800);

//BULL
boolean boomB = false;
PImage bull;
float xBull = random(0,800);
float yBull = random(0,800);

//PEOPLE
int boomPeople;

PImage cla;
PImage andrew;
PImage pier;
PImage rick;

float xPeople = random(0,800);
float yPeople = random(0,800);

float wPeople = 375/6;
float hPeople = 550/6;


float xPoint;
float yPoint;
float xVel = 5;
float yVel = 5;

float diamCapr = 100;
float diam = 90;



//Color Positions
float touch_r_down; 
float touch_g_down; 
float touch_b_down ;
  
float touch_r_up ;
float touch_g_up;
float touch_b_up;
  
float touch_r_left; 
float touch_g_left ;
float touch_b_left ;
float touch_r_right ;
float touch_g_right ;
float touch_b_right ;

void setup(){
  
  size(800, 800);

  oscP5 = new OscP5(this,7563);
  
  int i = int(random(0,labyrinths.length));
  labyrinthsToDraw = labyrinths[i];
  labyrinthsToDraw= loadImage("maze"+i+".png");
  
  /*for (int j = 0; j <people.length; j++){
    people[j] = loadImage("people"+j+".png");
  }*/
  

  
  bg = loadImage("Verdino.jpg");
  
  logo = loadImage("logo.png");
  
  //da mettere nel draw sennò si impalla se non piglia il nero

 
  if (red(get((int)(xChick-diam/2), (int)(yChick+diam/2))) != 0
  && green(get((int)(xChick-diam/2), (int)(yChick+diam/2))) != 0
  && blue(get((int)(xChick-diam/2), (int)(yChick+diam/2))) != 0
  
  &&red(get((int)(xChick+diam/2), (int)(yChick-diam/2))) != 0
  && green(get((int)(xChick+diam/2), (int)(yChick-diam/2))) != 0
  && blue(get((int)(xChick+diam/2), (int)(yChick-diam/2))) != 0
  
  &&red(get((int)(xChick-diam/2), (int)yChick)) != 0
  && green(get((int)(xChick-diam/2), (int)yChick)) != 0
  && blue(get((int)(xChick-diam/2), (int)yChick)) != 0
  
  &&red(get((int)(xChick+diam/2), (int)yChick)) != 0
  && green(get((int)(xChick+diam/2), (int)yChick)) != 0
  && blue(get((int)(xChick+diam/2), (int)yChick)) != 0
  
  &&red(get((int)xChick, (int)yChick)) != 0
  && green(get((int)xChick, (int)yChick)) != 0
  && blue(get((int)xChick, (int)yChick)) != 0) {
    
    imageMode(CENTER);
    chick = loadImage("chick.png");
  }

  pig = loadImage("pig.png");
  bull = loadImage("bull.png"); 

  
  cla = loadImage("cla.png");
  andrew = loadImage("andrew.png");
  pier = loadImage("pier.png");
  rick = loadImage("rick.png");
  
  boomPeople = (int)random(0,3);
  
  xPoint = width/2;
  yPoint = height/2;
  myRemoteLocation = new NetAddress("192.168.6.2",7563);
}

void draw()
{
  touch_r_down = red(get((int)xPoint, (int)(yPoint+diamCapr/2)));
  touch_g_down = green(get((int)xPoint,(int)(yPoint+diamCapr/2)));
  touch_b_down = blue(get((int)xPoint,(int)(yPoint+diamCapr/2)));
  
  touch_r_up = red(get((int)xPoint,(int)(yPoint-diamCapr/2)));
  touch_g_up = green(get((int)xPoint,(int)(yPoint-diamCapr/2)));
  touch_b_up = blue(get((int)xPoint,(int)(yPoint-diamCapr/2)));
  
  touch_r_left = red(get((int)(xPoint-diamCapr/2),(int)yPoint));
  touch_g_left = green(get((int)(xPoint-diamCapr/2),(int)yPoint));
  touch_b_left = blue(get((int)(xPoint-diamCapr/2),(int)yPoint));
  
  touch_r_right = red(get((int)(xPoint+diamCapr/2),(int)yPoint));
  touch_g_right = green(get((int)(xPoint+diamCapr/2),(int)yPoint));
  touch_b_right = blue(get((int)(xPoint+diamCapr/2),(int)yPoint));
  
  background(bg);
  
  imageMode(CENTER);
  image(labyrinthsToDraw,width/2,height/2);
  
  switch(boomPeople){
    case 0:
    image(cla,xPeople,yPeople,wPeople,hPeople);
    break;
    case 1:
    image(andrew,xPeople,yPeople,wPeople,hPeople);
    break;
    case 2:
    image(pier,xPeople,yPeople,wPeople,hPeople);
    break;
    case 3:
    image(rick,xPeople,yPeople,wPeople,hPeople);
    break;
  }
  
  //PEOPLE
  if(xPoint >= xPeople - (wPeople+diamCapr) && xPoint <= xPeople + (hPeople+diamCapr)
  && yPoint >= yPeople - (wPeople+diamCapr) && yPoint <= yPeople + (hPeople+diamCapr)
  && d == 1){ //d da cambiare con z del joystick!!

    float xNewPeople = random(0,width);
    float yNewPeople = random(0,height);
    
    if ( red(get((int)xNewPeople, (int)yNewPeople)) != 0
        && green(get((int)xNewPeople, (int)yNewPeople)) != 0
        && blue(get((int)xNewPeople, (int)yNewPeople)) != 0) {
          
          xPeople = xNewPeople;
          yPeople = yNewPeople;
          imageMode(CENTER);
          
          switch(boomPeople){
            case 0:
            image(andrew,xPeople,yPeople,wPeople,hPeople);
            boomPeople = 1;
            break;
            case 1:
            image(pier,xPeople,yPeople,wPeople,hPeople);
            boomPeople = 2;
            break;
            case 2:
            image(rick,xPeople,yPeople,wPeople,hPeople);
            boomPeople = 3;
            break;
            case 3:
            image(cla,xPeople,yPeople,wPeople,hPeople);
            boomPeople = 0;
            break;
          }
        }
      }
  
  /*if(boomAndrew == false){
    image(andrew,xAndrew,yAndrew,wPeople,hPeople);
  }
  if(boomCla == false){
    image(cla,xCla,yCla,wPeople,hPeople);
  }
  if(boomPier == false){
    image(pier,xPier,yPier,wPeople,hPeople);
  }
  if(boomRick == false){
    image(rick,xRick,yRick,wPeople,hPeople);
  }+/
  

  /*if(boomPeople == false){
    image(presetPeople,xPeople,yPeople,diam,diam);
  }*/
   
  if(boomC == false){
    image(chick,xChick,yChick,diam,diam);
  }
  if(boomP == false){
    image(pig,xPig,yPig,diam,diam);
  }
  if (boomB == false){
    image(bull,xBull,yBull,diam,diam);
  }
  
  imageMode(CENTER);
  image(logo,xPoint,yPoint,diamCapr,diamCapr);
  

  
/*
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
  && d == 1){
    boomPier = true;
    //mouseButton = 0;
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
  }*/
  

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
  && boomC == false && d == 1){
    boomC = true;
    float xNewChick = random(0,width);
    float yNewChick = random(0,height);
    if ( red(get((int)xNewChick, (int)yNewChick)) != 0
        && green(get((int)xNewChick, (int)yNewChick)) != 0
        && blue(get((int)xNewChick, (int)yNewChick)) != 0) {
    
    xChick = xNewChick;
    yChick = yNewChick;
    imageMode(CENTER);
    image(chick,xChick,yChick,diam,diam);
    boomC = false;
    }
    
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
  && boomP == false && d == 1){
    boomP = true;
    float xNewPig = random(0,width);
    float yNewPig = random(0,height);
    if ( red(get((int)xNewPig, (int)yNewPig)) != 0
        && green(get((int)xNewPig, (int)yNewPig)) != 0
        && blue(get((int)xNewPig, (int)yNewPig)) != 0) {
    
    xPig = xNewPig;
    yPig = yNewPig;
    imageMode(CENTER);
    image(pig,xPig,yPig,diam,diam);
    boomP = false;
    }
    
  }
  
  //BULL
  if(xPoint >= xBull - (diam/2 + diamCapr/2) && xPoint <= xBull + (diam/2 + diamCapr/2)
  && yPoint >= yBull - (diam/2 + diamCapr/2) && yPoint <= yBull + (diam/2 + diamCapr/2)
  && boomB == false){
    imageMode(CENTER);
    image(logo,width/2,height/2,diamCapr,diamCapr);
    xPoint = width/2;
    yPoint = height/2;
  }
  if(xPoint >= xBull - (diam+diamCapr) && xPoint <= xBull + (diam+diamCapr)
  && yPoint >= yBull - (diam+diamCapr) && yPoint <= yBull + (diam+diamCapr)
  && boomB == false && d == 1){
    boomB = true;
    float xNewBull = random(0,width);
    float yNewBull = random(0,height);
    if ( red(get((int)xNewBull, (int)yNewBull)) != 0
        && green(get((int)xNewBull, (int)yNewBull)) != 0
        && blue(get((int)xNewBull, (int)yNewBull)) != 0) {
    
    xBull = xNewBull;
    yBull = yNewBull;
    imageMode(CENTER);
    image(bull,xBull,yBull,diam,diam);
    boomB = false;
    }
  }
  
  //PEOPLE
  /*if(xPoint >= xPeople - (diam/2 + diamCapr/2) && xPoint <= xPeople + (diam/2 + diamCapr/2)
  && yPoint >= yPeople - (diam/2 + diamCapr/2) && yPoint <= yPeople + (diam/2 + diamCapr/2)
  && boomPeople == false){
    imageMode(CENTER);
    image(logo,width/2,height/2,diamCapr,diamCapr);
    xPoint = width/2;
    yPoint = height/2;
  }
  if(xPoint >= xPeople - (diam+diamCapr) && xPoint <= xPeople + (diam+diamCapr)
  && yPoint >= yPeople - (diam+diamCapr) && yPoint <= yPeople + (diam+diamCapr)
  && boomPeople == false && d == 1){
    boomPeople = true;
    float xNewPeople = random(0,width);
    float yNewPeople = random(0,height);
    if ( red(get((int)xNewPeople, (int)yNewPeople)) != 0
        && green(get((int)xNewPeople, (int)yNewPeople)) != 0
        && blue(get((int)xNewPeople, (int)yNewPeople)) != 0) {
    
    xPeople = xNewPeople;
    yPeople = yNewPeople;
    imageMode(CENTER);
    image(people[(int)random(0,people.length)],xPeople,yPeople,diam,diam);
    boomPeople = false;
    }
  }*/

}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
 
  //If address of oscMessage is /colour then change the shape and colour visualized
  if (theOscMessage.checkAddrPattern("/movement"))
  {
    //Get X value
    x = theOscMessage.get(0).floatValue();
   
    //Move to left & control black pixel
    if (Math.round(x) == -1){
      //println("mi sposto a sinistra"+ x);
      if(touch_r_left == 0 && touch_g_left == 0 && touch_b_left == 0){   
        xPoint = xPoint + xVel;
      }
      else{
        xPoint = xPoint - xVel;//move to left ù
      }
    }
    
    //Move to right & control black pixel
    if(Math.round(x) == 1) {
      //println("mi sposto a destra"+ x);
      if(touch_r_right == 0 && touch_g_right == 0 && touch_b_right == 0){   
         xPoint = xPoint - xVel;//move to right
      }
      else{
        xPoint = xPoint + xVel;//move to right
      }
    }
    
    //Get Y value
    y = theOscMessage.get(1).floatValue();
    
    //Move Up & control black pixel
    if (Math.round(y) == 1){
      if(touch_r_up == 0 && touch_g_up == 0 && touch_b_up == 0){   
         yPoint = yPoint + yVel;//move up
      }
      else{
        yPoint = yPoint - yVel;//move up
      }
    }
    
    
    //Move Down & control black pixel
    if(y < 0.4) {
      if(touch_r_down == 0 && touch_g_down == 0 && touch_b_down == 0){   
         yPoint = yPoint - yVel;//move up
      }
      else{
        yPoint = yPoint + yVel;//move down
      }
    }
    //Get Z digital value
  z = theOscMessage.get(2).floatValue();
  //println("z: "+z);
  
  //Get digital value of the sensor
  d = theOscMessage.get(3).floatValue();
  //println("d: "+d);
  }
 
}
