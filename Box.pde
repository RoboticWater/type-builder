class Box implements Entity {
  //PVector pos; 
  PVector size;
  int sides = 0x3F;
  //public Box(int x, int y, int z, int sX, int sY, int sZ) {
  //  pos = new PVector(x, y, z);
  //  size = new PVector(sX, sY, sZ);
  //}
  public Box(int sX, int sY, int sZ, int sides) {
    stroke(0);
    size = new PVector(sX, sY, sZ);
    this.sides = sides;
  }
  public void draw() {
    //pushMatrix();
    //translate(pos.x * xScale, pos.y * yScale, pos.z * zScale);
    if ((sides & 0x1) == 0x1) {
      beginShape();
      vertex(0, 0, 0);
      vertex(0, 0, size.z);
      vertex(0, size.y, size.z);
      vertex(0, size.y, 0);
      endShape(CLOSE);
    }
    if ((sides & 0x2) == 0x2) {
      beginShape();
      vertex(size.x, 0, 0);
      vertex(size.x, 0, size.z);
      vertex(size.x, size.y, size.z);
      vertex(size.x, size.y, 0);
      endShape(CLOSE);
    }
    if ((sides & 0x4) == 0x4) {
      beginShape();
      vertex(0, 0, 0);
      vertex(size.x, 0, 0);
      vertex(size.x, 0, size.z);
      vertex(0, 0, size.z);
      endShape(CLOSE);
    }
    if ((sides & 0x8) == 0x8) {
      beginShape();
      vertex(0, size.y, 0);
      vertex(size.x, size.y, 0);
      vertex(size.x, size.y, size.z);
      vertex(0, size.y, size.z);
      endShape(CLOSE);
    }
    if ((sides & 0x10) == 0x10) {
      beginShape();
      vertex(0, 0, 0);
      vertex(size.x, 0, 0);
      vertex(size.x, size.y, 0);
      vertex(0, size.y, 0);
      endShape(CLOSE);
    }
    if ((sides & 0x20) == 0x20) {
      beginShape();
      vertex(0, 0, size.z);
      vertex(size.x, 0, size.z);
      vertex(size.x, size.y, size.z);
      vertex(0, size.y, size.z);
      endShape(CLOSE);
    }
    //popMatrix();
  }
  public void delete() {
    
  }
}