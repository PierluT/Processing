import controlP5.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
ControlP5 cp5;

float x,y,z,d;  //coordinates of the shape (translation)

PImage[] labyrinths = new PImage[4];
PImage labyrinthsToDraw;


PImage logo;


//CHICK
boolean boomC = false;
float xChick = random(0,800);
float yChick = random(0,800);

//GIF CHICK
int numFramesC = 12;
int currentFrameC = 0;
PImage[] gifChick = new PImage[numFramesC];

//PIG
boolean boomP = false;
float xPig = random(0,800);
float yPig = random(0,800);

//GIF PIG
int numFramesP = 12;
int currentFrameP = 0;
PImage[] gifPig = new PImage[numFramesP];

//BULL
boolean boomB = false;
float xBull = random(0,800);
float yBull = random(0,800);

//GIF BULL
int numFramesB = 12;
int currentFrameB = 0;
PImage[] gifBull = new PImage[numFramesB];

//VELOCIRAPTOR
boolean boomV = false;
float xVeloc = random(0,800);
float yVeloc = random(0,800);

//GIF VELOCIRAPTOR
int numFramesV = 19;
int currentFrameV = 0;
PImage[] gifVeloc = new PImage[numFramesV];

//PEOPLE
boolean boomPeople = false;
int casePeople;

PImage cla;
PImage andrew;
PImage pier;
PImage rick;

float xPeople = random(0,800);
float yPeople = random(0,800);

float wPeople = 375/7;
float hPeople = 550/7;


float xPoint;
float yPoint;
float xVel = 5;
float yVel = 5;

float diamCapr = 95;
float diam = 85;



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


//GIF BACKGROUND
int numFrames = 40;
int currentFrame = 0;
PImage[] images = new PImage[numFrames];



void setup(){
  
  size(800, 800);

  oscP5 = new OscP5(this,7563);
  
  int i = int(random(0,labyrinths.length));
  labyrinthsToDraw = labyrinths[i];
  labyrinthsToDraw= loadImage("maze"+i+".png");
  
  
  //GIF BACKGROUND
  for(int b=0; b<images.length; b++){
      images[b] = loadImage("gif_"+b+".gif");
    }
  
  logo = loadImage("logo.png");
  
    
    //GIFCHICK
    for(int c=0; c<gifChick.length; c++){
      gifChick[c] = loadImage("chick_"+c+".gif");
    }
    
    //GIFVEL
    for(int v=0; v<gifVeloc.length; v++){
      gifVeloc[v] = loadImage("veloc_"+v+".gif");
    }
    
    //GIFBULL
    for(int b=0; b<gifBull.length; b++){
      gifBull[b] = loadImage("bull_"+b+".gif");
    }
    
    //GIFPIG
    for(int p=0; p<gifPig.length; p++){
      gifPig[p] = loadImage("pig_"+p+".gif");
    }
    

  
  cla = loadImage("cla.png");
  andrew = loadImage("andrew.png");
  pier = loadImage("pier.png");
  rick = loadImage("rick.png");
  
  casePeople = (int)random(0,3);
  
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
  
  
  //GIF BACKGROUND
  frameRate(24);
  currentFrame = (currentFrame+1) % numFrames;
  background(images[currentFrame]);
  
  imageMode(CENTER);
  image(labyrinthsToDraw,width/2,height/2);
  
  switch(casePeople){
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
  
  //PEOPLE on fire
  
   if(xPoint >= xPeople - (diam/2) && xPoint <= xPeople + (diam/2)
  && yPoint >= yPeople - (diam/2) && yPoint <= yPeople + (diam/2)
  && boomPeople == false){
    imageMode(CENTER);
    image(logo,width/2,height/2,diamCapr,diamCapr);
    xPoint = width/2;
    yPoint = height/2;
  }

  if(xPoint >= xPeople - (diamCapr) && xPoint <= xPeople + (diamCapr)
  && yPoint >= yPeople - (diamCapr) && yPoint <= yPeople + (diamCapr)
  && z == 0){ 
    boolean canDraw = false;
    while(canDraw == false){
    float xNewPeople = random(0,width);
    float yNewPeople = random(0,height);
    
    if (red(get((int)(xNewPeople+wPeople/2), (int)(yNewPeople+hPeople/2))) != 0
        && green(get((int)(xNewPeople+wPeople/2), (int)(yNewPeople+hPeople/2))) != 0
        && blue(get((int)(xNewPeople+wPeople/2), (int)(yNewPeople+hPeople/2))) != 0
        
        && red(get((int)(xNewPeople+wPeople/2), (int)(yNewPeople-hPeople/2))) != 0
        && green(get((int)(xNewPeople+wPeople/2), (int)(yNewPeople-hPeople/2))) != 0
        && blue(get((int)(xNewPeople+wPeople/2), (int)(yNewPeople-hPeople/2))) != 0

        && red(get((int)(xNewPeople-wPeople/2), (int)(yNewPeople+hPeople/2))) != 0
        && green(get((int)(xNewPeople-wPeople/2), (int)(yNewPeople+hPeople/2))) != 0
        && blue(get((int)(xNewPeople-wPeople/2), (int)(yNewPeople+hPeople/2))) != 0
        
        &&red(get((int)(xNewPeople-wPeople/2), (int)(yNewPeople-hPeople/2))) != 0
        && green(get((int)(xNewPeople-wPeople/2), (int)(yNewPeople-hPeople/2))) != 0
        && blue(get((int)(xNewPeople-wPeople/2), (int)(yNewPeople-hPeople/2))) != 0
        
        && red(get((int)(xNewPeople), (int)(yNewPeople+hPeople/2))) != 0
        && green(get((int)(xNewPeople), (int)(yNewPeople+hPeople/2))) != 0
        && blue(get((int)(xNewPeople), (int)(yNewPeople+hPeople/2))) != 0
        
        && red(get((int)(xNewPeople+wPeople/2), (int)(yNewPeople))) != 0
        && green(get((int)(xNewPeople+wPeople/2), (int)(yNewPeople))) != 0
        && blue(get((int)(xNewPeople+wPeople/2), (int)(yNewPeople))) != 0
        
        && red(get((int)(xNewPeople), (int)(yNewPeople-hPeople/2))) != 0
        && green(get((int)(xNewPeople), (int)(yNewPeople-hPeople/2))) != 0
        && blue(get((int)(xNewPeople), (int)(yNewPeople-hPeople/2))) != 0
        
        && red(get((int)(xNewPeople-wPeople/2), (int)(yNewPeople))) != 0
        && green(get((int)(xNewPeople-wPeople/2), (int)(yNewPeople))) != 0
        && blue(get((int)(xNewPeople-wPeople/2), (int)(yNewPeople))) != 0) {
          
          xPeople = xNewPeople;
          yPeople = yNewPeople;
          imageMode(CENTER);
          
          switch(casePeople){
            case 0:
            image(andrew,xPeople,yPeople,wPeople,hPeople);
            casePeople = 1;
            canDraw = true;
            break;
            case 1:
            image(pier,xPeople,yPeople,wPeople,hPeople);
            casePeople = 2;
            canDraw = true;
            break;
            case 2:
            image(rick,xPeople,yPeople,wPeople,hPeople);
            casePeople = 3;
            canDraw = true;
            break;
            case 3:
            image(cla,xPeople,yPeople,wPeople,hPeople);
            casePeople = 0;
            canDraw = true;
            break;
          }
          
        }
      }
  }

   
  
  if(boomC == false){
    currentFrameC = (currentFrameC+1) % numFramesC;
    image(gifChick[currentFrameC],xChick,yChick,diam,diam);
  }
  if (boomV == false){
    currentFrameV = (currentFrameV+1) % numFramesV;
    image(gifVeloc[currentFrameV],xVeloc,yVeloc,diam,diam);
  }
  if (boomB == false){
    currentFrameB = (currentFrameB+1) % numFramesB;
    image(gifBull[currentFrameB],xBull,yBull,diam,diam);
  }
  if (boomP == false){
    currentFrameP = (currentFrameP+1) % numFramesP;
    image(gifPig[currentFrameP],xPig,yPig,diam,diam);
  }
  
  
  
  
  imageMode(CENTER);
  image(logo,xPoint,yPoint,diamCapr,diamCapr);
  

 
  

  //CHICKEN
  
  if(xPoint >= xChick - (diam/2) && xPoint <= xChick + (diam/2)
  && yPoint >= yChick - (diam/2) && yPoint <= yChick + (diam/2)
  && boomC == false){
    imageMode(CENTER);
    image(logo,width/2,height/2,diamCapr,diamCapr);
    xPoint = width/2;
    yPoint = height/2;
  }
  
  
  if(xPoint >= xChick - (diamCapr) && xPoint <= xChick + (diamCapr)
  && yPoint >= yChick - (diamCapr) && yPoint <= yChick + (diamCapr)
  && boomC == false && d == 1){
    boomC = true;
    boolean canDraw = false;
    while(canDraw == false){
    
      float xNewChick = random(0,width);
      float yNewChick = random(0,height);
    
    if (red(get((int)(xNewChick+diam/2), (int)(yNewChick+diam/2))) != 0
        && green(get((int)(xNewChick+diam/2), (int)(yNewChick+diam/2))) != 0
        && blue(get((int)(xNewChick+diam/2), (int)(yNewChick+diam/2))) != 0
        
        && red(get((int)(xNewChick+diam/2), (int)(yNewChick-diam/2))) != 0
        && green(get((int)(xNewChick+diam/2), (int)(yNewChick-diam/2))) != 0
        && blue(get((int)(xNewChick+diam/2), (int)(yNewChick-diam/2))) != 0
        
        && red(get((int)(xNewChick-diam/2), (int)(yNewChick+diam/2))) != 0
        && green(get((int)(xNewChick-diam/2), (int)(yNewChick+diam/2))) != 0
        && blue(get((int)(xNewChick-diam/2), (int)(yNewChick+diam/2))) != 0
        
        &&red(get((int)(xNewChick-diam/2), (int)(yNewChick-diam/2))) != 0
        && green(get((int)(xNewChick-diam/2), (int)(yNewChick-diam/2))) != 0
        && blue(get((int)(xNewChick-diam/2), (int)(yNewChick-diam/2))) != 0
        
        && red(get((int)(xNewChick), (int)(yNewChick+diam/2))) != 0
        && green(get((int)(xNewChick), (int)(yNewChick+diam/2))) != 0
        && blue(get((int)(xNewChick), (int)(yNewChick+diam/2))) != 0
        
        && red(get((int)(xNewChick+diam/2), (int)(yNewChick))) != 0
        && green(get((int)(xNewChick+diam/2), (int)(yNewChick))) != 0
        && blue(get((int)(xNewChick+diam/2), (int)(yNewChick))) != 0
        
        && red(get((int)(xNewChick), (int)(yNewChick-diam/2))) != 0
        && green(get((int)(xNewChick), (int)(yNewChick-diam/2))) != 0
        && blue(get((int)(xNewChick), (int)(yNewChick-diam/2))) != 0
        
        && red(get((int)(xNewChick-diam/2), (int)(yNewChick))) != 0
        && green(get((int)(xNewChick-diam/2), (int)(yNewChick))) != 0
        && blue(get((int)(xNewChick-diam/2), (int)(yNewChick))) != 0) {
    
          xChick = xNewChick;
          yChick = yNewChick;
          canDraw = true;
          boomC = false;
    
    } 
    }
  }
  
  //VELOCIRAPTOR
  
  if(xPoint >= xVeloc - (diam/2) && xPoint <= xVeloc + (diam/2)
  && yPoint >= yVeloc - (diam/2) && yPoint <= yVeloc + (diam/2)
  && boomV == false){
    imageMode(CENTER);
    image(logo,width/2,height/2,diamCapr,diamCapr);
    xPoint = width/2;
    yPoint = height/2;
  }
  
  
  if(xPoint >= xVeloc - (diamCapr) && xPoint <= xVeloc + (diamCapr)
  && yPoint >= yVeloc - (diamCapr) && yPoint <= yVeloc + (diamCapr)
  && boomV == false && d == 1){
    boomV = true;
    boolean canDraw = false;
    while(canDraw == false){
    
      float xNewVeloc = random(0,width);
      float yNewVeloc = random(0,height);
    
    if (red(get((int)(xNewVeloc+diam/2), (int)(yNewVeloc+diam/2))) != 0
        && green(get((int)(xNewVeloc+diam/2), (int)(yNewVeloc+diam/2))) != 0
        && blue(get((int)(xNewVeloc+diam/2), (int)(yNewVeloc+diam/2))) != 0
        
        && red(get((int)(xNewVeloc+diam/2), (int)(yNewVeloc-diam/2))) != 0
        && green(get((int)(xNewVeloc+diam/2), (int)(yNewVeloc-diam/2))) != 0
        && blue(get((int)(xNewVeloc+diam/2), (int)(yNewVeloc-diam/2))) != 0
        
        && red(get((int)(xNewVeloc-diam/2), (int)(yNewVeloc+diam/2))) != 0
        && green(get((int)(xNewVeloc-diam/2), (int)(yNewVeloc+diam/2))) != 0
        && blue(get((int)(xNewVeloc-diam/2), (int)(yNewVeloc+diam/2))) != 0
        
        &&red(get((int)(xNewVeloc-diam/2), (int)(yNewVeloc-diam/2))) != 0
        && green(get((int)(xNewVeloc-diam/2), (int)(yNewVeloc-diam/2))) != 0
        && blue(get((int)(xNewVeloc-diam/2), (int)(yNewVeloc-diam/2))) != 0
        
        && red(get((int)(xNewVeloc), (int)(yNewVeloc+diam/2))) != 0
        && green(get((int)(xNewVeloc), (int)(yNewVeloc+diam/2))) != 0
        && blue(get((int)(xNewVeloc), (int)(yNewVeloc+diam/2))) != 0
        
        && red(get((int)(xNewVeloc+diam/2), (int)(yNewVeloc))) != 0
        && green(get((int)(xNewVeloc+diam/2), (int)(yNewVeloc))) != 0
        && blue(get((int)(xNewVeloc+diam/2), (int)(yNewVeloc))) != 0
        
        && red(get((int)(xNewVeloc), (int)(yNewVeloc-diam/2))) != 0
        && green(get((int)(xNewVeloc), (int)(yNewVeloc-diam/2))) != 0
        && blue(get((int)(xNewVeloc), (int)(yNewVeloc-diam/2))) != 0
        
        && red(get((int)(xNewVeloc-diam/2), (int)(yNewVeloc))) != 0
        && green(get((int)(xNewVeloc-diam/2), (int)(yNewVeloc))) != 0
        && blue(get((int)(xNewVeloc-diam/2), (int)(yNewVeloc))) != 0) {
    
          xVeloc = xNewVeloc;
          yVeloc = yNewVeloc;
          canDraw = true;
          boomV = false;
    } 
    }
  }
  
  
  
  //PIG
  if(xPoint >= xPig - (diam/2) && xPoint <= xPig + (diam/2)
  && yPoint >= yPig - (diam/2) && yPoint <= yPig + (diam/2)
  && boomP == false){
    imageMode(CENTER);
    image(logo,width/2,height/2,diamCapr,diamCapr);
    xPoint = width/2;
    yPoint = height/2;
  }
  if(xPoint >= xPig - (diamCapr) && xPoint <= xPig + (diamCapr)
  && yPoint >= yPig - (diamCapr) && yPoint <= yPig + (diamCapr)
  && boomP == false && d == 1){
    boomP = true;
    boolean canDraw = false;
    while(canDraw == false){
      
      float xNewPig = random(0,width);
      float yNewPig = random(0,height);
    if (red(get((int)(xNewPig+diam/2), (int)(yNewPig+diam/2))) != 0
        && green(get((int)(xNewPig+diam/2), (int)(yNewPig+diam/2))) != 0
        && blue(get((int)(xNewPig+diam/2), (int)(yNewPig+diam/2))) != 0
        
        && red(get((int)(xNewPig+diam/2), (int)(yNewPig-diam/2))) != 0
        && green(get((int)(xNewPig+diam/2), (int)(yNewPig-diam/2))) != 0
        && blue(get((int)(xNewPig+diam/2), (int)(yNewPig-diam/2))) != 0
        
        && red(get((int)(xNewPig-diam/2), (int)(yNewPig+diam/2))) != 0
        && green(get((int)(xNewPig-diam/2), (int)(yNewPig+diam/2))) != 0
        && blue(get((int)(xNewPig-diam/2), (int)(yNewPig+diam/2))) != 0
        
        &&red(get((int)(xNewPig-diam/2), (int)(yNewPig-diam/2))) != 0
        && green(get((int)(xNewPig-diam/2), (int)(yNewPig-diam/2))) != 0
        && blue(get((int)(xNewPig-diam/2), (int)(yNewPig-diam/2))) != 0
        
        && red(get((int)(xNewPig), (int)(yNewPig+diam/2))) != 0
        && green(get((int)(xNewPig), (int)(yNewPig+diam/2))) != 0
        && blue(get((int)(xNewPig), (int)(yNewPig+diam/2))) != 0
        
        && red(get((int)(xNewPig+diam/2), (int)(yNewPig))) != 0
        && green(get((int)(xNewPig+diam/2), (int)(yNewPig))) != 0
        && blue(get((int)(xNewPig+diam/2), (int)(yNewPig))) != 0
        
        && red(get((int)(xNewPig), (int)(yNewPig-diam/2))) != 0
        && green(get((int)(xNewPig), (int)(yNewPig-diam/2))) != 0
        && blue(get((int)(xNewPig), (int)(yNewPig-diam/2))) != 0
        
        && red(get((int)(xNewPig-diam/2), (int)(yNewPig))) != 0
        && green(get((int)(xNewPig-diam/2), (int)(yNewPig))) != 0
        && blue(get((int)(xNewPig-diam/2), (int)(yNewPig))) != 0) {
    
    xPig = xNewPig;
    yPig = yNewPig;
    canDraw = true;
    boomP = false;
        }
    }
    }
  
  
  //BULL
  if(xPoint >= xBull - (diam/2) && xPoint <= xBull + (diam/2)
  && yPoint >= yBull - (diam/2) && yPoint <= yBull + (diam/2)
  && boomB == false){
    imageMode(CENTER);
    image(logo,width/2,height/2,diamCapr,diamCapr);
    xPoint = width/2;
    yPoint = height/2;
  }
  if(xPoint >= xBull - (diamCapr) && xPoint <= xBull + (diamCapr)
  && yPoint >= yBull - (diamCapr) && yPoint <= yBull + (diamCapr)
  && boomB == false && d == 1){
    boomB = true;
    boolean canDraw = false;
    while(canDraw == false){
      float xNewBull = random(0,width);
      float yNewBull = random(0,height);
    if (red(get((int)(xNewBull+diam/2), (int)(yNewBull+diam/2))) != 0
        && green(get((int)(xNewBull+diam/2), (int)(yNewBull+diam/2))) != 0
        && blue(get((int)(xNewBull+diam/2), (int)(yNewBull+diam/2))) != 0
        
        && red(get((int)(xNewBull+diam/2), (int)(yNewBull-diam/2))) != 0
        && green(get((int)(xNewBull+diam/2), (int)(yNewBull-diam/2))) != 0
        && blue(get((int)(xNewBull+diam/2), (int)(yNewBull-diam/2))) != 0
        
        && red(get((int)(xNewBull-diam/2), (int)(yNewBull+diam/2))) != 0
        && green(get((int)(xNewBull-diam/2), (int)(yNewBull+diam/2))) != 0
        && blue(get((int)(xNewBull-diam/2), (int)(yNewBull+diam/2))) != 0

        &&red(get((int)(xNewBull-diam/2), (int)(yNewBull-diam/2))) != 0
        && green(get((int)(xNewBull-diam/2), (int)(yNewBull-diam/2))) != 0
        && blue(get((int)(xNewBull-diam/2), (int)(yNewBull-diam/2))) != 0
        
        && red(get((int)(xNewBull), (int)(yNewBull+diam/2))) != 0
        && green(get((int)(xNewBull), (int)(yNewBull+diam/2))) != 0
        && blue(get((int)(xNewBull), (int)(yNewBull+diam/2))) != 0
        
        && red(get((int)(xNewBull+diam/2), (int)(yNewBull))) != 0
        && green(get((int)(xNewBull+diam/2), (int)(yNewBull))) != 0
        && blue(get((int)(xNewBull+diam/2), (int)(yNewBull))) != 0
        
        && red(get((int)(xNewBull), (int)(yNewBull-diam/2))) != 0
        && green(get((int)(xNewBull), (int)(yNewBull-diam/2))) != 0
        && blue(get((int)(xNewBull), (int)(yNewBull-diam/2))) != 0
        
        && red(get((int)(xNewBull-diam/2), (int)(yNewBull))) != 0
        && green(get((int)(xNewBull-diam/2), (int)(yNewBull))) != 0
        && blue(get((int)(xNewBull-diam/2), (int)(yNewBull))) != 0) {
    
    xBull = xNewBull;
    yBull = yNewBull;
    canDraw = true;
    boomB = false;
    }
    }
  }
  


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
