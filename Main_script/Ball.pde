////////////////////////////FOR THE PROJECTILE TO BE LAUNCHED/////////////////////

Projectile projectile;

void loadProjectile()
{
  projectile = new Projectile(50,height-80);
}

void displayProjectile()
{
  projectile.display();
}

class Projectile
{
  Body ball;
  float ballRadius;
  
  //putting together the constructor
  //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
  Projectile(float x_, float y_)
  {    
    float x = x_;
    float y = y_;
    ballRadius = 10;
    
    Vec2 projectileStartingPos = new Vec2(x, y);
    
    //creating body shape
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(ballRadius);
    
    //creating body fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 0.8;
    fd.friction = 0.05;
    fd.restitution = 0.7;
    
    //body definition
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(projectileStartingPos.x,projectileStartingPos.y));
    
    //creating the body
    ball = box2d.createBody(bd);
    
    //fixing the fixtures
    ball.createFixture(fd);    
  }
  
  //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
  void startBallFlight()
  {
    //possibility to start the ball moving
    ball.setLinearVelocity(new Vec2(50,25));
  }
  
  //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
  void display()
  {
    Vec2 pos = box2d.getBodyPixelCoord(ball);
    // Get its angle of rotation
    float a = ball.getAngle();
    
    ellipseMode(RADIUS);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(117,57,7);
    stroke(0);
    strokeWeight(2);
    ellipse(0, 0, ballRadius, ballRadius);
    popMatrix();
  }
  
  /*boolean hitBuildingBlock()
  {
    return true;
  }*/
}
