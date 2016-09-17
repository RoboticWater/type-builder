public class Player {
  PVector pos, rot;
  Trail t;
  float speed;
  public Player() {
    pos = new PVector(width / 2, height / 2, 0);
    rot = new PVector();
    t = new Trail();
    speed = 5.0;
  }
  public void draw() {
    update();
    t.draw();
    pushMatrix();
    translate(pos.x, pos.y , pos.z);
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);
    box(20);
    popMatrix();
  }
  public void update() {
    rot.z += 0.1 * stick.getSlider("MOVEX").getValue();
    rot.x += 0.1 * -stick.getSlider("MOVEY").getValue();
    PVector dirVect = new PVector(0, 0, 1);
    rotateVectX(dirVect, rot.x);
    rotateVectY(dirVect, rot.y);
    rotateVectZ(dirVect, rot.z);
    dirVect.setMag(speed);
    //pos.add(dirVect);
  }
}