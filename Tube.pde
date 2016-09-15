public class Tube extends SixSided {
  public Tube(int x, int y, int z, int key) {
    super(Tube.class, x, y, z);
  }
  public void draw() {
    strokeWeight(3);
    stroke(255);
    if (sides == 0) {
      translate(xScale / 2, yScale / 2, zScale / 2);
      ellipse(0, 0, 10, 10);
    } else {
      if ((sides & 0x1) == 0) {
        line(xScale / 2, yScale / 2, zScale / 2, 0, yScale / 2, zScale / 2);
        //beginShape();
        //vertex(0, 0, 0);
        //vertex(0, 0, size.z);
        //vertex(0, size.y, size.z);
        //vertex(0, size.y, 0);
        //endShape(CLOSE);
      }
      if ((sides & 0x2) == 0) {
        line(xScale / 2, yScale / 2, zScale / 2, xScale, yScale / 2, zScale / 2);
        //beginShape();
        //vertex(size.x, 0, 0);
        //vertex(size.x, 0, size.z);
        //vertex(size.x, size.y, size.z);
        //vertex(size.x, size.y, 0);
        //endShape(CLOSE);
      }
      if ((sides & 0x4) == 0) {
        line(xScale / 2, yScale / 2, zScale / 2, xScale / 2, 0, zScale / 2);
        //beginShape();
        //vertex(0, 0, 0);
        //vertex(size.x, 0, 0);
        //vertex(size.x, 0, size.z);
        //vertex(0, 0, size.z);
        //endShape(CLOSE);
      }
      if ((sides & 0x8) == 0) {
        line(xScale / 2, yScale / 2, zScale / 2, xScale / 2, yScale, zScale / 2);
        //beginShape();
        //vertex(0, size.y, 0);
        //vertex(size.x, size.y, 0);
        //vertex(size.x, size.y, size.z);
        //vertex(0, size.y, size.z);
        //endShape(CLOSE);
      }
      if ((sides & 0x10) == 0) {
        line(xScale / 2, yScale / 2, zScale / 2, xScale / 2, yScale / 2, 0);
        //beginShape();
        //vertex(0, 0, 0);
        //vertex(size.x, 0, 0);
        //vertex(size.x, size.y, 0);
        //vertex(0, size.y, 0);
        //endShape(CLOSE);
      }
      if ((sides & 0x20) == 0) {
        line(xScale / 2, yScale / 2, zScale / 2, xScale / 2, yScale / 2, zScale);
        //beginShape();
        //vertex(0, 0, size.z);
        //vertex(size.x, 0, size.z);
        //vertex(size.x, size.y, size.z);
        //vertex(0, size.y, size.z);
        //endShape(CLOSE);
      }
    }
  }
  public void delete() {
    
  }
}