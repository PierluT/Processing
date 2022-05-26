PImage labyrinth;
PImage logo;
PImage bg;
int x = 162;
int y = 162;

int diam = 20;

void setup(){
  size(620, 620);
  labyrinth = loadImage("labyrinth.png"); 
  bg = loadImage("Grass.jpg");
  logo = loadImage("Animal0.png");
}

void draw()
{
  //background(bg);
  background(255);
  image(labyrinth,width/2,height/2);

//se esco dal labrinto??
/*
if((x > 155) && (x < 180) && (y < 15)){
textSize(48);
textAlign(CENTER);
fill(255,0,0);
text("YOU WIN!",width/2,height/2);
}*/

 
  float touch = red(get(x,y));
  if(touch <= 124 && touch >=100){
    x = width-350;
    y = height-350; 
  }
  imageMode(CENTER);
  image(logo,x,y,diam,diam);

  println(mouseX + "," + mouseY);
}


void keyPressed(){
if ((key == CODED) && (keyCode == UP)){
y--;
} 
if ((key == CODED) && (keyCode == DOWN)){
y++;
} 
if ((key == CODED) && (keyCode == RIGHT)){
x++;
} 
if ((key == CODED) && (keyCode == LEFT)){
x--;
}
}
