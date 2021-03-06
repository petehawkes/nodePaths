class Node {

  PVector pos;
  float rad;
  float rotation = 0;
  boolean active = false;
  boolean readyToCheck = false;
  float activeAlpha = 0; 

  Node (PVector _pos, float _rad, float _rotation ) {
    pos = _pos;
    rad = _rad;
    rotation = _rotation;
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rotation);

    noStroke();
    fill(200);
    ellipse(0, 0, rad*2, rad*2); 

    noStroke();
    fill(0, activeAlpha);
    ellipse(0, 0, rad, rad); 

    noFill();
    stroke(150);
    line(0, 0, 10, 0);

    popMatrix();
  }

  void activate() {
    active = true;
    activeAlpha = 255;
  }

  void update() {
    // update things

    if (readyToCheck) {
      check();
      readyToCheck = false;
    }

    if (active && !readyToCheck) {
      readyToCheck = true;
      active = false;
    }



    if (activeAlpha>1) { 
      activeAlpha *= .7;
    } 
    else {
      activeAlpha = 0;
    }
  } 

  void check() {
    // 
    float len = rad*2;
    PVector triggerPos = new PVector(cos(rotation)*len, sin(rotation)*len);
    triggerPos.add(pos);

    checkNeighbor(triggerPos);
  }
};


