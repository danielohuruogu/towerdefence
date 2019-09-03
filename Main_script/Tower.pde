///////////////////////////BUILDING SCREEN//////////////////////

ArrayList<BuildingBlock> buildingBlocks;

int currentBuildingBlockOption = 0;

void loadBuildingBlocks()
{
  buildingBlocks = new ArrayList<BuildingBlock>();
}

void addBuildingBlock()
{
  BuildingBlock b = new BuildingBlock(mouseX,mouseY);
  buildingBlocks.add(b);
}

void displayBuildingBlocks()
{
  for(BuildingBlock p: buildingBlocks)
  {
    p.display();
  }
  
  for (int i = buildingBlocks.size()-1; i >= 0; i--)
    {
      BuildingBlock b = buildingBlocks.get(i);
      if (b.done())
      {
        buildingBlocks.remove(i);
      }
    }
}

void updateBlockChoice()
{ 
  if (buildingBlocks.size()>0)
  { 
    BuildingBlock currentBlock = buildingBlocks.get(buildingBlocks.size()-1); //grabs the last body added to the array list

    if (mousePressed==true)
    {
      currentBlock.changeOrientation(); //while the mouse is pressed down, the blocks orientation is changed
    }
  }
}

class BuildingBlock {

  // We need to keep track of a Body and a width and height
  Body body;
  BodyDef bd;
  float w;
  float h;
  
  float r;
  
  Vec2 mousePos = new Vec2 (mouseX,mouseY);

  //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
  BuildingBlock(float x, float y)
  {
    w = 40;
    h = 10;
    // Add the box to the box2d world
    makeBody(new Vec2(x, y), w, h); //could have done this all in the constructor instead of creating a separate function
  } 
  
  //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
  void makeBody(Vec2 center, float w_, float h_)
  {    
    
    // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    // Define the body and make it from the shape
    bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    //creating the body to be used
    body = box2d.createBody(bd);
    body.createFixture(sd,1);
  }
  
  //''''''''''''''''''''This function removes the particle from the box2d world'''''''//
  void killBody()
  {
    box2d.destroyBody(body);
  }

  //'''''''''''''''''''''''''''''''''Is the particle ready for deletion?'''''''''''''''// NOT SURE IF NEEDED, BUT WILL KEEP
  boolean done()
  {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the edge of the screen?
    if (pos.x > width+w*h)
    {
      killBody();
      return true;
    } else
    return false;
  }

  //''''''''''''''''''''''''''''''''''''''''''''''''' Drawing the box'''''''''''''''''//
  void display()
  {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(189,141,0);
    stroke(0);
    strokeWeight(2);
    rect(0, 0, w, h);
    popMatrix();
  }
  
  boolean contains(float x, float y)
  {
    Vec2 worldPoint = box2d.coordPixelsToWorld(x,y);
    Fixture f = body.getFixtureList();
    boolean inside = f.testPoint(worldPoint);
    return inside;
  }
  
  void changeOrientation()
  {
    if (currentBuildingBlockOption == 0)
    body.setFixedRotation(true);
    body.setTransform(mousePos, 0);
    
    if (currentBuildingBlockOption == 1)
    body.setFixedRotation(true);
    body.setTransform(mousePos, 90);
    
    if (currentBuildingBlockOption == 2)
    body.setFixedRotation(true);
    body.setTransform(mousePos, -45);
    
    if (currentBuildingBlockOption == 3)
    body.setFixedRotation(true);
    body.setTransform(mousePos, 45);
  }
  
  //will need a function that will create a joint with up to 8 members
  //each connection will have an array 8 big filled with the info from blocks nearby
  /*void connections()
  {
    
  }*/
}

//////************--------------------------------------------------******************////////////////////

// will create a part of the screen to be used for a building zone - a wall to demarcate area

BuildingBoundary wallBoundary;

void loadWallBoundary()
{
  wallBoundary = new BuildingBoundary(width*0.55, height-110, 15, 40);
}

void displayWallBoundary()
{
  wallBoundary.displayBoundary();
}

class BuildingBoundary //didn't really need a class for this, but it tidies everything up
{
  float xCoord, yCoord;
  float widthWall, heightWall;
  Body wallBody;
  
  BuildingBoundary(float x_, float y_, float w_, float h_)
  { 
    xCoord = x_;
    yCoord = y_;
    widthWall = w_;
    heightWall = h_;
    
    BodyDef bd = new BodyDef(); //defined the body in Box2d
    bd.position.set(box2d.coordPixelsToWorld(xCoord, yCoord)); //setting ground position
    bd.type = BodyType.STATIC; //static body that ain't moving
    wallBody = box2d.createBody(bd); //body is set and created
    
    //figuring out coordinates
    float box2dW = box2d.scalarPixelsToWorld(widthWall/2); //this sends the pixel width to the width in the world
    float box2dH = box2d.scalarPixelsToWorld(heightWall/2); //sends pixel height to the real world height
    
    PolygonShape ps = new PolygonShape();
    ps.setAsBox(box2dW, box2dH); //is gonna be a rectangle with dimensions set as those passed through argument
    
    wallBody.createFixture(ps,1); //shortened step, where the density is set as 1. You would go through the whole shebang if you want the object with a different density and restitution
  }
  
  void displayBoundary() {
    fill(77,50,4);
    noStroke();
    rectMode(CENTER);
    rect(xCoord, yCoord, widthWall, heightWall);
  }
}
