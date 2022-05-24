class Bubble{
  float x;
  float y;
  float diameter;
  
  PImage img;
  
  Bubble(PImage tempImg, float tempX, float tempY, float tempD){
    img = tempImg;
    x = tempX;
    y = tempY;
    diameter = tempD;
  }
  
    void display(){
    imageMode(CENTER);
    image(img,x,y,diameter,diameter);
  }
  
  void ascend(){
    y--;
    x++;
  }
  
  
  void top(){
    if(y<diameter/2){
      y=diameter/2;
    }
  }
  void bottom(){
    if(y>height-diameter/2){
      y=height-diameter/2;
    }
  }
  void left(){
    if(x<diameter/2){
      x=diameter/2;
    }
  }
  void right(){
    if(x>width-diameter/2){
      x=width-diameter/2;
    }
  }
}
