
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

  background(255);
  //
  // step through all nodes. update, draw.
  for (int i=0; i<allNodes.size(); i++) {
    Node n = (Node) allNodes.get(i);    
    n.update();
    n.display();
  }

}


void addNode(PVector newPos, float rad, float rotation) {
  allNodes.add(new Node(newPos, rad, rotation));
}

void checkNeighbor(PVector newPos) {
  for (int i=0; i<allNodes.size(); i++) {
    Node n = (Node) allNodes.get(i);  
    if (n.pos.dist(newPos) < 10) {
       n.activate(); 
    }
  }
}

void addSomeNodes() {

  // a line
  for (int i=0; i<30; i++) {
    PVector p = new PVector(100, 100);
    addNode(new PVector(100 + i*(nodeRad*2), 50), nodeRad, 0);
  }
  
  
  // a circle
  PVector center = new PVector(400, 300);
  int circleNodes = 32;
  for (int i=0; i<circleNodes; i++) {
    float radian = (float(i)/circleNodes)*TWO_PI;
    float newRad = 100;
    PVector newPos = new PVector(newRad*cos(radian), newRad*sin(radian));
    newPos.add(center);
    addNode(newPos, nodeRad, radian+PI/2);  
  }
  
  // connector
  addNode(new PVector(400, 200), nodeRad, -PI/2);
  addNode(new PVector(400, 180), nodeRad, -PI/2);
  
  // another circle
  circleNodes = 48;
  for (int i=0; i<circleNodes; i++) {
    float radian = (float(i)/circleNodes)*TWO_PI;
    float newRad = 140;
    PVector newPos = new PVector(newRad*cos(radian), newRad*sin(radian));
    newPos.add(center);
    addNode(newPos, nodeRad, radian+PI/2);  
  }
  
  // another connector
  addNode(new PVector(400, 160), nodeRad, -PI/2);
  addNode(new PVector(400, 140), nodeRad, -PI/2);
  
  // one more circle
  circleNodes = 60;
  for (int i=0; i<circleNodes; i++) {
    float radian = (float(i)/circleNodes)*TWO_PI;
    float newRad = 180;
    PVector newPos = new PVector(newRad*cos(radian), newRad*sin(radian));
    newPos.add(center);
    addNode(newPos, nodeRad, radian+PI/2);  
  }
  
  /* short cut test
  addNode(new PVector(400, 200), nodeRad, .65);
  addNode(new PVector(415, 212), nodeRad, .65);
  addNode(new PVector(430, 224), nodeRad, .65);
  addNode(new PVector(445, 236), nodeRad, .65);
  addNode(new PVector(460, 248), nodeRad, .65);
  addNode(new PVector(475, 260), nodeRad, .65);
  addNode(new PVector(490, 272), nodeRad, .65);
  */
  
  
}


void mousePressed() {
    //addMoreCircles();
  PVector m = new PVector(mouseX, mouseY);
    
  for (int i=0; i<allNodes.size(); i++) {
    Node n = (Node) allNodes.get(i); 
    if (m.dist(n.pos) < nodeRad) {
       n.activate();
    }
  }
    
    
    
   
    
}


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



