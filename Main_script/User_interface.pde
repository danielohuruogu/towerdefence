///////FOR SCREEN 1////////////

Button flatBlock;
Button uprightBlock;
Button diagdownBlock;
Button diagupBlock;

int blockCounter;
String bC;

void displayInterface()
{
  textAlign(CENTER,CENTER);
  fill(100);
  textSize(16);
  text("select a tower block", 350, height*0.7);
  
  blockCounter = 50 - buildingBlocks.size();
  String bC = str(blockCounter);
  
  text("no. of blocks left: " + bC, 350, height*0.73);
  
  text("boundary", (width*0.5), height*0.88);
}

void loadButtons()
{
  flatBlock = new Button(350, 100, 75, 75, 33, 112, 39, 0, 350, 100, 78, 19.5);
  uprightBlock = new Button(350, 250, 75, 75, 33, 112, 39, 1, 350, 250, 19.5, 78);
  diagdownBlock = new Button(350, 400, 75, 75, 33, 112, 39, 2, 350, 400, 74.5, 67.5);
  diagupBlock = new Button(350, 550, 75, 75, 33, 112, 39, 3, 350, 550, 67.5, 74.5);
}

void drawButtons()
{
  flatBlock.create();
  uprightBlock.create();
  diagdownBlock.create();
  diagupBlock.create();
}

void displayHighlighter()
{
  if (currentBuildingBlockOption == 0)
    flatBlock.highlighter();
    
  if (currentBuildingBlockOption == 1)
    uprightBlock.highlighter();
    
  if (currentBuildingBlockOption == 2)
    diagdownBlock.highlighter();
    
  if (currentBuildingBlockOption == 3)
    diagupBlock.highlighter();
}

class Button
{
  PVector position;
  PVector size;
  color colour;
  boolean buttonActivated;
  int buttonImage;
  PVector imagePosition;
  PVector imageSize;
  
  PImage flatBlockImage;
  PImage uprightBlockImage;
  PImage diagdownBlockImage;
  PImage diagupBlockImage;
  
  Button(float x, float y, float w, float h, int r, int g, int b, int i, float i_x, float i_y, float i_w, float i_h)
  {
    position = new PVector(x,y);
    size = new PVector(w,h);
    colour = color(r,g,b);
    buttonImage = i;
    imagePosition = new PVector(i_x,i_y);
    imageSize = new PVector(i_w,i_h);
    
    flatBlockImage = loadImage("lying flat building block.PNG");
    uprightBlockImage = loadImage("upright building block.PNG");
    diagdownBlockImage = loadImage("diag down building block.PNG");
    diagupBlockImage = loadImage("diag up building block.PNG");
  }
  
  void create()
  {
    //drawing each button for the building block selector
    noStroke();
    rectMode(CENTER);
    fill(colour);
    rect(position.x, position.y, size.x, size.y);
    imageMode(CENTER);

    if (buttonImage == 0)
    {
     image(flatBlockImage, imagePosition.x, imagePosition.y, imageSize.x, imageSize.y);
    }
    if (buttonImage == 1)
    {
     image(uprightBlockImage, imagePosition.x, imagePosition.y, imageSize.x, imageSize.y);
    }
    if (buttonImage == 2)
    {
     image(diagdownBlockImage, imagePosition.x, imagePosition.y, imageSize.x, imageSize.y);
    }
    if (buttonImage == 3)
    {
     image(diagupBlockImage, imagePosition.x, imagePosition.y, imageSize.x, imageSize.y);
    }

  }
  
  boolean buttonActivated()
  {
    if (mouseX>position.x-(size.x/2) && mouseX<position.x+(size.x/2) && mouseY>position.y-(size.y/2) && mouseY<position.y+(size.y/2))
    {
      return true;
    }
    else 
    {
      return false;
    }
  }
  
  void highlighter()
  {
    stroke(255,0,0);
    strokeWeight(4);
    line((position.x-size.x/2),(position.y-size.y/2),(position.x-size.x/2),(position.y+size.y/2));
    line((position.x-size.x/2),(position.y+size.y/2),(position.x+size.x/2),(position.y+size.y/2));
    line((position.x+size.x/2),(position.y+size.y/2),(position.x+size.x/2),(position.y-size.y/2));
    line((position.x+size.x/2),(position.y-size.y/2),(position.x-size.x/2),(position.y-size.y/2));
  }
}
