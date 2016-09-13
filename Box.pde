class Box implements Entity {
  PVector size;
  int sides = 0x3F;
  public Box(int sX, int sY, int sZ, int sides) {
    stroke(0);
    size = new PVector(sX, sY, sZ);
    this.sides = sides;
  }
  public void draw() {
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
  }
  public void delete() {
    
  }
}