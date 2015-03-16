class HexNode {

  PVector pos;
  PShape hex;
  int[] index = new int[2];
  int id;
  
  boolean rollOver = false; 
  boolean activeNeighbor = false;

  HexNode (PVector _pos, int _id, int _col, int _row) {
    pos = _pos;
    id = _id;
    index[0] = _col;
    index[1] = _row;
    hex = loadShape("hex.svg");
  }
  
  void findNeighbors () {
    
  }
  
  /*
  
  HEX NEIGHBOR LOGIC
  
                      (4,0)
                 (3,0)
            (2,0)     (4,1)
       (1,0)     (3,1)
  (0,0)     (2,1)     (4,2)
       (1,1)     (3,2)
  (0,1)     (2,2)     (4,3)
       (1,2)     (3,3)
  (0,2)     (2,3)     (4,4)
       (1,3)     (3,4)
  (0,3)     (2,4)
       (1,4)
  (0,4)
  
  top         = ( 0, -1)
  top-right   = (+1,  0)  
  down-right  = (+1, +1)
  down        = ( 0, +1)
  down-left   = (-1,  0)
  top-left    = (-1, -1)
  
  
  LESS EFFECTIVE
  
  (0,0)   (1,0)   (2,0)   (3,0)
      (0,1)   (1,1)   (2,1)   (3,1)
  (0,2)   (1,2)   (2,2)   (3,2)
      (0,3)   (1,3)   (2,3)   (3,3)
  (0,4)   (1,4)   (2,4)   (3,4)
      (0,5)   (1,5)   (2,5)   (3,5)
  (0,6)   (1,6)   (2,6)   (3,6)
      (0,7)   (1,7)   (2,7)   (3,7)
  
                           shifted
  top         = ( 0, -2)
  top-right   = ( 0, -1)   (+1, -1)    
  down-right  = ( 0, +1)   (+1, +1)
  down        = ( 0, +2)
  down-left   = (-1, +1)   ( 0, +1)
  top-left    = (-1, -1)   ( 0, -1)
  
  
  */




  void display() {
    pushMatrix();
    translate(pos.x, pos.y);   
    shape(hex, 0, 0);
    
    if (rollOver) {
      shape(hex, 0, 0); 
    }
    
    if (activeNeighbor) {
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
    
    popMatrix();
  }
  
  void activate() {
    HexNode n;
    rollOver = true; 
    // north
    n = (HexNode) allNodes.get(safeIndex(id - hexCols));  
    n.activeNeighbor = true;
    // northwest
    n = (HexNode) allNodes.get(safeIndex(id - hexCols - 1));  
    n.activeNeighbor = true;
    // northeast
    n = (HexNode) allNodes.get(safeIndex(id + 1));  
    n.activeNeighbor = true;
    // southwest
    n = (HexNode) allNodes.get(safeIndex(id - 1));  
    n.activeNeighbor = true;
    // south
    n = (HexNode) allNodes.get(safeIndex(id + hexCols));  
    n.activeNeighbor = true;
    // southeast
    n = (HexNode) allNodes.get(safeIndex(id + hexCols + 1));  
    n.activeNeighbor = true;
  }
  
  void deactivate() {
    HexNode n;
    rollOver = false;
    // north
    n = (HexNode) allNodes.get(safeIndex(id - hexCols));  
    n.activeNeighbor = false;
    // northwest
    n = (HexNode) allNodes.get(safeIndex(id - hexCols - 1));  
    n.activeNeighbor = false;
    // northeast
    n = (HexNode) allNodes.get(safeIndex(id + 1));  
    n.activeNeighbor = false;
    // southwest
    n = (HexNode) allNodes.get(safeIndex(id - 1));  
    n.activeNeighbor = false;
    // south
    n = (HexNode) allNodes.get(safeIndex(id + hexCols));  
    n.activeNeighbor = false;
    // southeast
    n = (HexNode) allNodes.get(safeIndex(id + hexCols + 1));  
    n.activeNeighbor = false;
  }



  void update() {
    if (abs(mouseX - pos.x) < hexSpace/2 && abs(mouseY - pos.y) < hexSpace/2) {
       activate();
    } else if (rollOver) {
       deactivate();
    }
  } 


};


