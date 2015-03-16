
ArrayList allNodes;
ArrayList allTriggers;

int hexCols, hexRows;
float hexSpace, scalar;

boolean showNumbers = false;
boolean dragging = false;
int startId, endId, rollId;

PShape hexBacker, hexArrow;

void setup() {

  size(800, 600);
  background(255); 
  
  scalar = 1.0;
  
  hexSpace = 35 * scalar;

  allNodes = new ArrayList();
  allTriggers = new ArrayList();

  hexCols = ceil(width/hexSpace)+2;
  hexRows = ceil(height*3/2/hexSpace)+2;
  
  hexBacker = loadShape("hex.svg");
  hexArrow = loadShape("arrow.svg");

  addSomeNodes();
}



void draw() {

  background(0);
  //
  // step through all nodes. update, draw.  
  for (int i=0; i<allNodes.size(); i++) {
    HexNode n = (HexNode) allNodes.get(i);    
    n.update();
    n.display();
  }
  
}

int safeIndex (int i_in) {
  int i_out = i_in;
  if (i_in < 0) {
    i_out = 0;
  } 

  if (i_in > ceil(hexCols*hexRows) - 2) {
    i_out = ceil(hexCols*hexRows) - 2;
  }
  return i_out;
}


void addNode(PVector newPos, int id, int c, int r) {
  allNodes.add(new HexNode(newPos, id, c, r));
}





void addSomeNodes() {
  int id = 0;

  // 
  for (int i=0; i<hexRows; i++) {
    for (int j=0; j<hexCols; j++) {
      //addNode(new PVector(200 + i*(hexSpace) + (j%2 * hexSplit), 200 + j*hexSplit*.575 ), i, j);
      addNode(new PVector(j*hexSpace, i*hexSpace*1.15 - j*(hexSpace*.575) ), id, i, j);
      id++;
    }
  }

  /*
  
   HEX NEIGHBOR LOGIC
   
   (04)
   (03)
   (02)      (09)
   (01)      (08)
   (00)      (07)      (14)
   (06)      (13)
   (05)      (12)      (19)
   (11)      (18)
   (10)      (17)      (24)
   (16)      (23)
   (15)      (22)    
   (21)     
   (20)
   
   top         =  id - hexCols
   top-right   =  id + 1
   down-right  =  id + hexCols + 1
   down        =  id + hexCols
   down-left   =  id - 1
   top-left    =  id - hexCols - 1
   
   
   */
}


void startDrag (int _id) {
  startId = _id;
  dragging = true;
}

float hexRadians (float rad) {
  return rad;
}

void mousePressed() {
  // showNumbers = !showNumbers;
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      showNumbers = !showNumbers;
    }
  }
  if (key == ' ') {
    println("SPACE:" + rollId); 
  }
}

void connect (int id) {
  HexNode start = (HexNode) allNodes.get(startId); 
  HexNode end = (HexNode) allNodes.get(id); 

  for (int i=0; i<6; i++) {
    println(i+"  "+start.neighbors[i] +":" + id);
    if (start.neighbors[i] == id) {
      start.addDirection(end.pos, id);
      startId = id;
      i=7;
    }
  }
}



void mouseReleased() {
  if (dragging) {
    dragging = false;
    startId = -1;
  }
}



class HexNode {

  PVector pos;
  PVector dir;
  PShape hex, arrow;

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
      fill(200);
      textAlign(CENTER);
      text(id, 0, 3);
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


