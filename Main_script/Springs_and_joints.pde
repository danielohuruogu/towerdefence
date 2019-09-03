//FOR MOUSE JOINT

Spring spring;

void loadMouseJoint()
{
  spring = new Spring();
}

void dragObject()
{
  for (BuildingBlock p: buildingBlocks)
  {
    if (p.contains(mouseX,mouseY))
    {
      spring.bind(mouseX,mouseY,p);//something needs to be initialised here
    }
  }
}

void releaseObject()
{
  spring.destroy();
}

void updateSpringToNewMousePos()
{
  spring.update(mouseX,mouseY);
}

class Spring
{
  MouseJoint mouseJoint;
  
  Spring()
  {
    mouseJoint = null;
  }
  
  void update(float x, float y)
  {
    if (mouseJoint != null)
    {
      Vec2 mouseWorld = box2d.coordPixelsToWorld(x,y);
      mouseJoint.setTarget(mouseWorld);
    }
  }
  
  void bind(float x, float y, BuildingBlock box)
  {
    MouseJointDef md = new MouseJointDef();
    
    md.bodyA = box2d.getGroundBody();
    md.bodyB = box.body;
    
    Vec2 mp = box2d.coordPixelsToWorld(x,y);
    
    md.target.set(mp);   
    md.maxForce = 1000.0 * box.body.m_mass;
    md.frequencyHz = 5.0;
    md.dampingRatio = 0.9;
    
    mouseJoint = (MouseJoint) box2d.world.createJoint(md);
  }
  
  void destroy()
  {
    if (mouseJoint != null)
    {
      box2d.world.destroyJoint(mouseJoint);
      mouseJoint = null;
    }
  }
}

//FOR BUILDING PIECES JOINTS
