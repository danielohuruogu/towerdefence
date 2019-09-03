///////////////FOR THE CLOUD SETUP/////////////////
int cloudNumber;

Cloud[] totalclouds;

GroundBoundary floorBoundary;

void loadEnvironment()
{
  cloudNumber = round(random(5,25));

  totalclouds = new Cloud[cloudNumber];
  for(int i = 0; i<cloudNumber; i++)
  {
   totalclouds[i] = new Cloud();
  }
  
  //Box2D world setup//  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  box2d.setGravity(0,-10);
  
  floorBoundary = new GroundBoundary(width/2, height-30, width, 60);
};

///////////////////////////////////////
void drawEnvironment()
{
  box2d.step(); //to enable the library to step
  
  for(int i = 0; i<cloudNumber; i++)
  {
    totalclouds[i].update();
  }
  floorBoundary.displayBoundary();  
};

/////////////////////////////////////////
class Cloud
{
  float xPos;
  float yPos;

  float xVelocityMin;
  float xVelocityMax;
  float xVelocity;

  float screenStart = windowPosition.x;
  float screenEnd = screenSize.x;

  int cloudSize = round(random(1,4));

  float[] xPosition = new float[cloudSize];
  float[] yPositionOffset = new float[cloudSize];
  float[] xDiam = new float[cloudSize];
  float[] yDiam = new float[cloudSize];

  float xDiameter = random(40,50);
  float yDiameter = random(40,50);
  float yOffset = random(-10,10);
  
  float shadowOffset = 5;

  float overlap = xDiameter/2;

  //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//

  Cloud (){
    xPos = random(width);
    yPos = random(windowPosition.y, 350);

    xPosition[0] = xPos;
    if (xPosition.length>1)
       for(int i = 1; i<cloudSize; i++)
       {
       xPosition[i] = xPosition[i-1] + overlap;
       }
    for (int i = 0; i<cloudSize; i++)
    {
      yPositionOffset[i] = random(-10,10);
    }

    xVelocityMin = 0.5;
    xVelocityMax = 0.9;
    xVelocity = random(xVelocityMin, xVelocityMax);
  }

  //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
  void move() {
    for(int i = 0; i<cloudSize; i++)
    {
    xPosition[i] += xVelocity;
    }
  }

  //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
  void createNewClouds() {

    if ((xPosition[0]-xDiameter)>screenEnd)
    {
      xPosition[0] = screenStart-(xDiameter*xPosition.length);
      if (xPosition.length>1)
       for(int i = 1; i<cloudSize; i++)
       {
       xPosition[i] = xPosition[i-1] + overlap;
       }
      for (int i = 0; i<cloudSize; i++)
      {
       yPositionOffset[i] = random(-10,10);
      }

    xVelocityMin = 0.5;
    xVelocityMax = 0.9;
    xVelocity = random(xVelocityMin, xVelocityMax);
    }
  }

  //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
  void display() {
    for(int i = 0; i<cloudSize; i++)
    {
    ellipseMode(CENTER);
    fill (224, 224, 224);
    noStroke();
    ellipse(xPosition[i], yPos + yPositionOffset[i] + shadowOffset, xDiameter, yDiameter);
        
    fill(255, 255, 255);
    ellipse(xPosition[i], yPos + yPositionOffset[i], xDiameter, yDiameter);
    }
  }

  //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
  void update() {
    move();
    display();
    createNewClouds();
  }
}

class GroundBoundary //didn't really need a class for this, but it tidies everything up
{
  float xCoord, yCoord;
  float widthGround, thicknessGround;
  Body b;
  
  GroundBoundary(float x_, float y_, float w_, float h_) {  //this is so that you can manually set the values of each "cookie" to whatever you want, instead of it being parametric
    xCoord = x_;
    yCoord = y_;
    widthGround = w_;
    thicknessGround = h_;
    
    BodyDef bd = new BodyDef(); //defined the body in Box2d
    bd.position.set(box2d.coordPixelsToWorld(xCoord, yCoord)); //setting ground position
    bd.type = BodyType.STATIC; //static body that ain't moving
    b = box2d.createBody(bd); //body is set and created
    
    //figuring out coordinates
    float box2dW = box2d.scalarPixelsToWorld(widthGround/2); //this sends the pixel width to the width in the world
    float box2dH = box2d.scalarPixelsToWorld(thicknessGround); //sends pixel height to the real world height
    
    PolygonShape ps = new PolygonShape();
    ps.setAsBox(box2dW, box2dH); //is gonna be a rectangle with dimensions set as those passed through argument
    
    b.createFixture(ps,1); //shortened step, where the density is set as 1. You would go through the whole shebang if you want the object with a different density and restitution
  }
  
  void displayBoundary() {
    fill(77,50,4);
    noStroke();
    rectMode(CENTER);
    rect(xCoord, yCoord, widthGround, thicknessGround);
    fill(6,166,9);
    rectMode(CORNER);
    rect(0, yCoord-thicknessGround, widthGround, thicknessGround/2);
  }
}
