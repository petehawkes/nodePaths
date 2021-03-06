
ArrayList allNodes;
ArrayList allTriggers;

int hexSpace = 40;
int hexCols, hexRows;

boolean showNumbers = false;
boolean dragging = false;
int startId, endId, rollId;

void setup() {

  size(800, 600);
  background(255); 
  //smooth();
  
  //frameRate(2);

  allNodes = new ArrayList();
  allTriggers = new ArrayList();
  
  hexCols = width/hexSpace+2;
  hexRows = height*3/2/hexSpace+2;

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
   if (i_in > allNodes.size()-1) {
      i_out = allNodes.size() - 1; 
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
}

void connect (int id) {
  HexNode start = (HexNode) allNodes.get(startId); 
  HexNode end = (HexNode) allNodes.get(id); 
  start.addDirection(end.pos);
  startId = id;
}

void mouseReleased() {
   if (dragging) {
      dragging = false;
   } 
}




