class HexNode {

  PVector pos;
  PVector dir;
  PShape hex, arrow;

  int[] neighbors = new int[6];

  int id, followerId; // position within allNodes
  int direction; // 0-5: top, topRight, botRight, botLeft, topLeft
  
  int activeDelay = 10;
  int activeStamp = 0;
  
  float dirRadians;
  float activeSize;

  boolean rollOver = false; 
  boolean active = false;


  HexNode (PVector _pos, int _id, int _col, int _row) {
    pos = _pos;
    dir = new PVector(0, 0);
    id = _id;
    hex = hexBacker;
    arrow = hexArrow;
    followerId = -1;
    findNeighbors();
  }

  void findNeighbors () {
    //
    neighbors[0] = safeIndex(id - hexCols);  
    neighbors[1] = safeIndex(id + 1);  
    neighbors[2] = safeIndex(id + hexCols + 1);
    neighbors[3] = safeIndex(id + hexCols);  
    neighbors[4] = safeIndex(id - 1);  
    neighbors[5] = safeIndex(id - hexCols - 1); 
    //
  }


  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    scale(scalar); 
    if ( followerId != -1) { // draw arrow if follower exists
      pushMatrix();
      rotate(dirRadians);
      shape(arrow, 0, 0);
      popMatrix();
    }
    shape(hex, 0, 0);

    if (rollOver) {
      shape(hex, 0, 0);
    }
    
    if (activeSize > 1) {
       fill(255);
       noStroke();
       ellipse(0, 0, activeSize, activeSize);
    }

    if (id == startId) {
      pushMatrix();
      scale(.4, .4);
      shape(hex, 0, 0); 
      popMatrix();
    }

    // SHOW GRID NUMBERS 
    if (showNumbers) {
      fill(255);
      textSize(8);
      fill(200);
      textAlign(CENTER);
      text(id, 0, -7);
      fill(255, 0, 0);
      text(followerId, 0, 12);
    }

    popMatrix();
  }

  void activate() {
    HexNode n;
    rollOver = true; 
    rollId = id;
  }


  void deactivate() {
    HexNode n;
    rollOver = false;
  }


  void checkRollover() {
    if (abs(mouseX - pos.x) < hexSpace/2 && abs(mouseY - pos.y) < hexSpace/2) {
      activate();
      if (mousePressed) {
        if (!dragging) {
          startDrag(id);
        } 
        else {
          if (startId != id) {
            connect(id);
          }
        }
      }
    }
    else if (rollOver) {
      deactivate();
    }
  }


  void addDirection (PVector newPos, int _id) { 
    dir.x = (newPos.x - pos.x);
    dir.y = (newPos.y - pos.y);
    dir.normalize();
    dirRadians = -hexRadians(atan2(dir.x, dir.y)) + PI;
    //
    followerId = _id;
  }
  
  void checkReady () {
    
    if (active) {
      if (millis() - activeStamp > activeDelay) {
         active = false;
         activateNode(followerId); 
      }
    } 
   
  }
  
  void activateMe () {
     activeStamp = millis();
     activeSize = hexSpace/2;
     active = true; 
  }
  
  void degrade() {
    if (activeSize > 1) activeSize *= .9;
  }

  void update() {
    checkRollover();
    checkReady();
    degrade();
  }
};

