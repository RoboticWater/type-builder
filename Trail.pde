public class Trail {
  PVector pos, rot;
  ArrayList<PVector> posList, rotList;
  public Trail() {
    posList = new ArrayList();
    rotList = new ArrayList();
    pos = new PVector();
    rot = new PVector();
  }
  public void draw() {
    stroke(#ff0000);
    strokeWeight(3);
    noFill();
    update();
    beginShape();
    for (int i = 0; i < posList.size(); i++) {
      PVector offset = new PVector(-40 * sin(i * 0.1), 0);
      if (i % 3 == 0 || i > posList.size() - 3) {
        rotateVectX(offset, rotList.get(i).x);
        rotateVectY(offset, rotList.get(i).y);
        rotateVectZ(offset, rotList.get(i).z);
        offset.add(posList.get(i));
        curveVertex(offset.x, offset.y, offset.z);
      }
    }
    endShape();
    beginShape();
    for (int i = 0; i < posList.size(); i++) {
      PVector offset = new PVector(40 * sin(i * 0.1), 0);
      if (i % 3 == 0 || i > posList.size() - 3) {
        rotateVectX(offset, rotList.get(i).x);
        rotateVectY(offset, rotList.get(i).y);
        rotateVectZ(offset, rotList.get(i).z);
        offset.add(posList.get(i));
        curveVertex(offset.x, offset.y, offset.z);
      }
    }
    endShape();
  }
  public void update() {
    pos.x = cam1.position()[0];
    pos.y = cam1.position()[1];
    pos.z = cam1.position()[2];
    rot.x = cam1.attitude()[1];
    rot.y = cam1.attitude()[0];
    rot.z = cam1.attitude()[2];
    if (posList.size() > 0 && pos != posList.get(posList.size() - 1)) {
      posList.add(pos.get());
      rotList.add(rot.get());
    } else if (posList.size() == 0) {
      posList.add(pos.get());
      rotList.add(rot.get());
    }
  }
}