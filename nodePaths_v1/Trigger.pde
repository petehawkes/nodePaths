class Trigger {
  
  PVector pos;
  float rad = 3;
  int counter = 1;
  boolean killMe = false;

  Trigger (PVector _pos) {
    pos = _pos;
  }
  
  void display() {
     pushMatrix();
     translate(pos.x, pos.y);
     noStroke();
     fill(255, 120, 0); // orange
     ellipse(0, 0, rad*2, rad*2); 
     popMatrix(); 
  }
  
  void update() {
    // update things
    if (counter>0) {
      counter--;
    } else {
      killMe = true;
    } 
  }
  

  
};
  
  
