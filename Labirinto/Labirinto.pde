PImage labyrinth;
PImage logo;
PImage bg;
int xPoint;
int yPoint;

int diam = 50;

void setup(){
  size(620, 620);
  labyrinth = loadImage("labyrintho.png"); 
  bg = loadImage("Verdino.jpg");
  logo = loadImage("Animal0.png");
  xPoint = width-350;
  yPoint = height-350;
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
  
  

  float touch_r = red(get(xPoint,yPoint));
  float touch_g = green(get(xPoint,yPoint));
  float touch_b = blue(get(xPoint,yPoint));

  if(touch_r == 0 && touch_g == 0 && touch_b == 0 && (keyCode == UP)){   
    yPoint++; 
  }
  if(touch_r == 0 && touch_g == 0 && touch_b == 0 && (keyCode == DOWN)){   
    yPoint--; 
  }
  if(touch_r == 0 && touch_g == 0 && touch_b == 0 && (keyCode == LEFT)){   
    xPoint++; 
  }
  if(touch_r == 0 && touch_g == 0 && touch_b == 0 && (keyCode == RIGHT)){   
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
