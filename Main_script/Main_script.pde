import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;

//Box2d world
Box2DProcessing box2d;

//Processing world
PVector screenSize;
PVector windowPosition;
PVector windowSize;

//for switching + changing between screens
int screen;

void setup()
{  
  size(1400,900,P3D);
  smooth();
  
  screenSize = new PVector(width, height);
  windowPosition = new PVector(0,0);
  
  frameRate(60);
  
  loadEnvironment();
  
  loadButtons();
  
  loadProjectile();
  
  loadBuildingBlocks();
  
  loadMouseJoint();
  
  loadWallBoundary();
  
  screen = 0;  
}

void draw()
{
  //////////for the welcome screen at the beginning/////////////
  if (screen == 0)
  {
    background(196,253,255);
    drawEnvironment();

    fill(45,138,39);
    rectMode(CENTER);
    rect(700,450,350,250);
    textAlign(CENTER,CENTER);
    fill(255);
    textSize(30);
    text("TOWER DEFENCE", 700, 400);
    textSize(14);
    text("build the best structure to take on the invasion!", 700, 450);
    fill(138,44,29);
    rectMode(CENTER);
    rect(700,500,75,65);
    fill(255);
    textAlign(CENTER,CENTER);
    text("START",700,500);
  }
  
  ///////////for the main building screen//////////
  if (screen == 1)
  {
    background(196,253,255);
    drawEnvironment();
    
    drawButtons();
  
    displayBuildingBlocks();
    
    displayInterface();
    
    updateSpringToNewMousePos();
    
    displayWallBoundary();
    
    displayHighlighter();
    
    updateBlockChoice();
  }
  
  ////////////timer/preparing to launch screen//////////////////
  if (screen == 2)
  {
    displayProjectile();
  }
  
  //////////////////ball is launched///////////////////////
  if (screen == 3)
  {    
  }
  
  ///////////////////final screen with the score////////////////
  if (screen == 4)
  {   
  }
}

void mouseClicked()
{
  //here you have to write down every change that'll occur when the mouse is clicked
  //switching from welcome screen to main building screen
 if (screen == 0)
 {
   if (mouseX>662 && mouseX<738 && mouseY>467 && mouseY<533)
   {
     screen=1;
     //ball will have a linear velocity
     //display the buttons here
   }
 }
 
 /////switching from main building screen to timer/prepping to launch screen
 if (screen == 1)
 {
   
   ////////for the button presses
   //if (create conditions around buttons
 }
 
 /////switching from prepping to ball launch
 if (screen == 2)
 {
   projectile.startBallFlight();
 }
 
 /////switching from launch to final score and reset
 if (screen == 3)
 {
 }
}

void mousePressed()
{
  if (screen == 1)
  {
    if (mouseX>width*0.55)
    {
      if (buildingBlocks.size() < 50)
       {
         addBuildingBlock();
       }
       dragObject();
    }
  }
  //here will also be code to create the mouse joint
}

void mouseReleased()
{
  if (screen == 1)
  {
    releaseObject();
    //create code to set the position to the mouse position at point of release
  }
  //here will be the condition where the connection is made
  
  //here will be code to destroy the mouse joint
}

void keyPressed()
{
  if (keyCode == UP)
  {
    currentBuildingBlockOption--;
    if (currentBuildingBlockOption<0)
        currentBuildingBlockOption=0;
  }
  else if (keyCode == DOWN)
  {
    currentBuildingBlockOption++;
    if (currentBuildingBlockOption>3)
        currentBuildingBlockOption=3;
  }
}
