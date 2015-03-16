



int hexCols, hexRows;
float hexSpace, scalar;

boolean showNumbers = false;
boolean dragging = false;
boolean primaryConnection = true;
int initId, startId, endId, rollId, rollCount;

PShape hexBacker, hexArrow0, hexArrow1;

NodeGroup hexNodes;


void setup() {

  size(1024, 768);
  background(255); 
  
  hexNodes = new NodeGroup();

  scalar = 1;
  hexSpace = 35 * scalar;
  
  hexCols = ceil(width/hexSpace)+2;
  hexRows = ceil(height*3/2/hexSpace)+2;

  hexBacker = loadShape("hex.svg");
  hexArrow0 = loadShape("arrow0.svg");
  hexArrow1 = loadShape("arrow1.svg");

  addSomeNodes();
  
}



void draw() {

  background(0);
  hexNodes.run();
  
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



void addSomeNodes() {
  int id = 0;
  // 
  for (int i=0; i<hexRows; i++) {
    for (int j=0; j<hexCols; j++) {
      //addNode(new PVector(200 + i*(hexSpace) + (j%2 * hexSplit), 200 + j*hexSplit*.575 ), i, j);
      hexNodes.addNode(new PVector(j*hexSpace, i*hexSpace*1.15 - j*(hexSpace*.575) ), id, i, j);
      id++;
    }
  }

  /*
  
   HEX NEIGHBOR LOGIC
   
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


void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      showNumbers = !showNumbers;
    }
  }
  if (key == CODED) {
    if (keyCode == SHIFT) {
      primaryConnection = false;
    }
  }
  if (key == ' ') {
    hexNodes.setTimer();
    hexNodes.activateNode(rollId);
  }
}

void keyReleased() {
  primaryConnection = true; 
}

void mousePressed() {
  initId = rollId;
  rollCount = 0;
}

void mouseReleased() {
  if (dragging) {
    dragging = false;
    //println(initId +":"+rollId +":"+rollCount);
    if (initId == rollId && rollCount == 0) {
        hexNodes.clearNode(initId);
    }
    startId = -1;
  }
}


