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
      }
      if ((sides & 0x2) == 0) {
        line(xScale / 2, yScale / 2, zScale / 2, xScale, yScale / 2, zScale / 2);
      }
      if ((sides & 0x4) == 0) {
        line(xScale / 2, yScale / 2, zScale / 2, xScale / 2, 0, zScale / 2);
      }
      if ((sides & 0x8) == 0) {
        line(xScale / 2, yScale / 2, zScale / 2, xScale / 2, yScale, zScale / 2);
      }
      if ((sides & 0x10) == 0) {
        line(xScale / 2, yScale / 2, zScale / 2, xScale / 2, yScale / 2, 0);
      }
      if ((sides & 0x20) == 0) {
        line(xScale / 2, yScale / 2, zScale / 2, xScale / 2, yScale / 2, zScale);
      }
    }
  }
  public void delete() {
    
  }
}