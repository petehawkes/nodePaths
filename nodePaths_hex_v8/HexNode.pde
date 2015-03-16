class HexNode {

  PVector pos;
  PVector dir;
  PShape hex, arrow0, arrow1;

  int[] neighbors = new int[6];

  int id, followerId0, followerId1; // position within allNodes
  int direction; // 0-5: top, topRight, botRight, botLeft, topLeft

  float dirRadians0, dirRadians1;
  float activeSize;

  boolean rollOver = false; 
  boolean readyToGo = false;
  boolean active = false;
  int queueCount = 0;


  HexNode (PVector _pos, int _id, int _col, int _row) {
    pos = _pos;
    dir = new PVector(0, 0);
    id = _id;
    hex = hexBacker;
    arrow0 = hexArrow0;
    arrow1 = hexArrow1;
    followerId0 = followerId1 = -1;
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
    if ( followerId0 != -1) { // draw arrow if follower exists
      pushMatrix();
      rotate(dirRadians0);
      shape(arrow0, 0, 0);
      popMatrix();
    }
    if ( followerId1 != -1) { // draw arrow if follower exists
      pushMatrix();
      rotate(dirRadians1);
      shape(arrow1, 0, 0);
      popMatrix();
    }
    shape(hex, 0, 0);

    if (rollOver) {
      shape(hex, 0, 0);
    }

    if (activeSize > 1) {
      pushMatrix();
      scale(.95);
      tint(255, map(activeSize, 0, 50, 0, 150));
      image(hexImage, 0, 0);
      popMatrix();
      /*
      fill(150, 255, 0, 80);
      noStroke();
      ellipse(0, 0, activeSize, activeSize);
      fill(150, 255, 150);
      ellipse(0, 0, activeSize/2, activeSize/2);
      */
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
      //text(followerId0, -10, 12);
      //text(followerId1, 10, 12);
      text(queueCount, 0, 12);
    }

    popMatrix();
  }


  void activateRollOver() {
    if (!rollOver) {
      HexNode n;
      rollOver = true; 
      rollId = id;
      rollCount++;
    }
  }


  void checkRollOver() {
    if (abs(mouseX - pos.x) < hexSpace/2 && abs(mouseY - pos.y) < hexSpace/2) {
      activateRollOver();
      if (mousePressed) {
        if (!dragging) {
          startDrag(id);
        } 
        else {
          if (startId != id) {
            hexNodes.connect(id);
          }
        }
      }
    }
    else if (rollOver) {
      deactivate();
    }
  }

  void deactivate() {
    HexNode n;
    rollOver = false;
  }

  void addDirection (PVector newPos, int _id) { 
    dir.x = (newPos.x - pos.x);
    dir.y = (newPos.y - pos.y);
    dir.normalize();

    //
    if (primaryConnection) {
      if (_id != followerId1) {
        followerId0 = _id;
        dirRadians0 = -hexRadians(atan2(dir.x, dir.y)) + PI;
      }
    } 
    else {
      if (_id != followerId0) {
        followerId1 = _id; 
        dirRadians1 = -hexRadians(atan2(dir.x, dir.y)) + PI;
      }
    }
  }

  void advanceNext() {
    if (active) {   
      hexNodes.queueNode(followerId0);
      hexNodes.queueNode(followerId1);
      active = false;
    }
  }
  
  void setActive() {
    if (queueCount == 1) {
       activateMe(); 
    }
    queueCount = 0;
  }

  void degrade() {
    if (activeSize > 1) activeSize *= .5;
  }

  void clearMe () {
    followerId0 = followerId1 = -1;
  }

  void activateMe () {
    activeSize = 50*scalar;
    active = true;
  }
};

