class HexNode {

  PVector pos;
  PVector dir;
  PShape hex, arrow;

  int[] index = new int[2];
  int[] neighbors = new int[6];

  int id, followerId; // position within allNodes
  int direction; // 0-5: top, topRight, botRight, botLeft, topLeft
  float dirRadians;

  boolean rollOver = false; 
  boolean activeNeighbor = false;


  HexNode (PVector _pos, int _id, int _col, int _row) {
    pos = _pos;
    dir = new PVector(0, 0);
    id = _id;
    index[0] = _col;
    index[1] = _row;
    hex = hexBacker;
    arrow = hexArrow;
    followerId = -1;
    findNeighbors();
  }

  void findNeighbors () {
    //
    if (id == 250) println(safeIndex(id+1)+ ":" +(id+1));
    neighbors[0] = safeIndex(id - hexCols);  
    neighbors[1] = safeIndex(id + 1);  
    neighbors[2] = safeIndex(id + hexCols + 1);
    neighbors[3] = safeIndex(id + hexCols);  
    neighbors[4] = safeIndex(id - 1);  
    neighbors[5] = safeIndex(id - hexCols - 1); 
    //
    if (id == 250) println(neighbors);
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
      textAlign(RIGHT);
      text(index[0], -4, 3);
      textAlign(LEFT);
      text(index[1], 3, 3);
      fill(0);
      textAlign(CENTER);
      text(id, 0, 13);
    }

    /*stroke(100, 255, 0);
     noFill();
     line(0, 0, dir.x*20, dir.y*20);
     */
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
    followerId = id;
  }


  void update() {
    checkRollover();
  }
};

