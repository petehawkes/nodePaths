
ArrayList allNodes;
ArrayList allTriggers;
int nodeRad = 10;

void setup() {

  size(800, 600);
  background(255); 
  //smooth();
  
  //frameRate(2);

  allNodes = new ArrayList();
  allTriggers = new ArrayList();

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


void addNode(PVector newPos, int c, int r) {
  allNodes.add(new HexNode(newPos, c, r));
}


void checkNeighbor(PVector newPos) {
  for (int i=0; i<allNodes.size(); i++) {
    HexNode n = (HexNode) allNodes.get(i);  
    if (n.pos.dist(newPos) < 10) {
       n.activate(); 
    }
  }
}


void addSomeNodes() {
  
  int hexSpace = 23;
  int hexSplit = hexSpace/2;
  
  int cols = width/hexSpace+2;
  int rows = height*3/2/hexSpace+2;

  // a line
  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {
      //addNode(new PVector(200 + i*(hexSpace) + (j%2 * hexSplit), 200 + j*hexSplit*.575 ), i, j);
      addNode(new PVector(j*hexSpace, i*hexSpace*1.15 - j*(hexSpace*.575) ), i, j);
    }
  }
  
  
  
}


void mousePressed() {
    //addMoreCircles();
  PVector m = new PVector(mouseX, mouseY);
    
  for (int i=0; i<allNodes.size(); i++) {
    HexNode n = (HexNode) allNodes.get(i); 
    if (m.dist(n.pos) < nodeRad) {
       n.activate();
    }
  }
    
    
    
   
    
}


