// all nodes

class NodeGroup {
  ArrayList nodesList; // An arraylist for all the boids
  float x;
  float y;

  int timeDelay = 10;
  int timeStamp = 0;

  NodeGroup () {
    nodesList = new ArrayList(); // Initialize the arraylist
  }

  void run() {
    //
    // do this everytime
    for (int i=0; i<nodesList.size(); i++) {
      HexNode n = (HexNode) nodesList.get(i); 
      n.checkRollOver(); 
      n.degrade();
      n.display();
    }
    //
    // on a delay. reset on activate.
    if (millis() - timeStamp > timeDelay) {
      HexNode n;
      for (int i=0; i<nodesList.size(); i++) {
        n = (HexNode) nodesList.get(i);    
        n.advanceNext();
      }
      for (int i=0; i<nodesList.size(); i++) {
        n = (HexNode) nodesList.get(i);    
        n.setActive();
      }
      timeStamp = millis();
    }
  }

  void setTimer() {
    timeStamp = millis();
  }

  void addNode(PVector newPos, int id, int c, int r) {
    nodesList.add(new HexNode(newPos, id, c, r));
  }

  void activateNode (int id) {
    if (id != -1) {
      HexNode n = (HexNode) nodesList.get(id); 
      n.activateMe();
      //println("activate:"+id);
    }
  }
  
  void queueNode (int id) {
    if (id != -1) {
      HexNode n = (HexNode) nodesList.get(id); 
      n.readyToGo = true;
      n.queueCount++;
      //println("activate:"+id);
    }
  }

  void connect (int id) {
    HexNode start = (HexNode) nodesList.get(startId); 
    HexNode end = (HexNode) nodesList.get(id); 

    for (int i=0; i<6; i++) {
      //println(i+"  "+start.neighbors[i] +":" + id);
      if (start.neighbors[i] == id) {
        start.addDirection(end.pos, id);
        startId = id;
        i = 7;
      }
    }
  }

  void clearNode (int id) {
    HexNode n = (HexNode) nodesList.get(id);
    n.clearMe();
  }
}

