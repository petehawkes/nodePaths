class HexNode {

  PVector pos;
  PShape hex;
  int[] index = new int[2];
  
  
  float rad;
  float rotation = 0;
  boolean active = false;
  boolean readyToCheck = false;
  float activeAlpha = 0; 

  HexNode (PVector _pos, int _col, int _row) {
    pos = _pos;
    index[0] = _col;
    index[1] = _row;
    hex = loadShape("hex.svg");
  }
  
  void findNeighbors () {
    
  }
  
  /*
  
  HEX NEIGHBOR LOGIC
  
                      (4,0)
                 (3,0)
            (2,0)     (4,1)
       (1,0)     (3,1)
  (0,0)     (2,1)     (4,2)
       (1,1)     (3,2)
  (0,1)     (2,2)     (4,3)
       (1,2)     (3,3)
  (0,2)     (2,3)     (4,4)
       (1,3)     (3,4)
  (0,3)     (2,4)
       (1,4)
  (0,4)
  
  top         = ( 0, -1)
  top-right   = (+1,  0)  
  down-right  = (+1, +1)
  down        = ( 0, +1)
  down-left   = (-1,  0)
  top-left    = (-1, -1)
  
  
  LESS EFFECTIVE
  
  (0,0)   (1,0)   (2,0)   (3,0)
      (0,1)   (1,1)   (2,1)   (3,1)
  (0,2)   (1,2)   (2,2)   (3,2)
      (0,3)   (1,3)   (2,3)   (3,3)
  (0,4)   (1,4)   (2,4)   (3,4)
      (0,5)   (1,5)   (2,5)   (3,5)
  (0,6)   (1,6)   (2,6)   (3,6)
      (0,7)   (1,7)   (2,7)   (3,7)
  
                           shifted
  top         = ( 0, -2)
  top-right   = ( 0, -1)   (+1, -1)    
  down-right  = ( 0, +1)   (+1, +1)
  down        = ( 0, +2)
  down-left   = (-1, +1)   ( 0, +1)
  top-left    = (-1, -1)   ( 0, -1)
  
  
  */




  void display() {
    pushMatrix();
    translate(pos.x, pos.y);   
    shape(hex, 0, 0);
    
    /*
    // SHOW GRID NUMBERS 
    fill(255);
    textSize(8);
    textAlign(RIGHT);
    text(index[0], -4, 3);
    textAlign(LEFT);
    text(index[1], 3, 3);
    */
    
    popMatrix();
  }

  void activate() {
    active = true;
    activeAlpha = 255;
  }

  void update() {
    
  } 

  void check() {
    // 
    float len = rad*2;
    PVector triggerPos = new PVector(cos(rotation)*len, sin(rotation)*len);
    triggerPos.add(pos);

    checkNeighbor(triggerPos);
  }
};


