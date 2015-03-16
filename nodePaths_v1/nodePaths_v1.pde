
ArrayList allNodes;
ArrayList allTriggers;
int nodeRad = 10;

void setup() {

  size(800, 600, P3D);
  background(255); 
  //smooth();
  
  //frameRate(20);

  allNodes = new ArrayList();
  allTriggers = new ArrayList();

  addSomeNodes();
}



void draw() {

  background(255);
  checkTriggers();
  //
  // step through all nodes. update, draw.
  for (int i=0; i<allNodes.size(); i++) {
    Node n = (Node) allNodes.get(i);    
    n.update();
    n.display();
  }
  
  //
  // step through all triggers. update, draw.
  for (int i=0; i<allTriggers.size(); i++) {
    Trigger t = (Trigger) allTriggers.get(i);    
    
    if (t.killMe) {
      // kill dead triggers
      allTriggers.remove(i);
    } else {
      t.update();
      t.display();
    }
    
  }
}


void addNode(PVector newPos, float rad, float rotation) {
  allNodes.add(new Node(newPos, rad, rotation));
}

void addTrigger(PVector newPos) {
  allTriggers.add(new Trigger(newPos));
}

void addSomeNodes() {

  for (int i=0; i<30; i++) {
    PVector p = new PVector(100, 100);
    addNode(new PVector(100 + i*(nodeRad*2), 100), nodeRad, 0);
  }
  
  PVector center = new PVector(400, 300);
  int circleNodes = 30;
  for (int i=0; i<circleNodes; i++) {
    float radian = (float(i)/circleNodes)*TWO_PI;
    float newRad = 100;
    PVector newPos = new PVector(newRad*cos(radian), newRad*sin(radian));
    newPos.add(center);
    addNode(newPos, nodeRad, radian+PI/2);  
    
  }
  
}

void checkTriggers() {
  
  //
  // step through all triggers. update, draw.

  for (int i=0; i<allTriggers.size(); i++) {
    boolean triggerHit = false;
    Trigger t = (Trigger) allTriggers.get(i);  
    for (int j=0; j<allNodes.size(); j++) {
      Node n = (Node) allNodes.get(j);  
      if (t.pos.dist(n.pos) < 10) {
         n.activate(); 
         triggerHit = true;
      }
    }
    if (triggerHit) {
      allTriggers.remove(i);
    }
  }
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


