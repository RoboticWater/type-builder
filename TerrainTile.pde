public class TerrainTile implements Entity {
  float offset;
  TerrainTile[] ajnt = new TerrainTile[8]; //N NE E SE S SW W NW;
  float[] verts = {0, 0, 0, 0};
  int num;
  public TerrainTile(float offset, TerrainTile[] ajnt) {
    this.offset = offset;
    this.ajnt = ajnt;
    num = cursor[0];
    calcVerts(1);
  }
  void draw() {
    if (renderQuad) {
      stroke(0);
      beginShape();
      vertex(0, verts[3], 0);
      vertex(xScale, verts[0], 0);
      vertex(xScale, verts[1], zScale);
      vertex(0, verts[2], zScale);
      endShape(CLOSE);
    } else {
      stroke(255);
      line(xScale / 2, yScale, zScale / 2, xScale / 2, offset, zScale / 2);
    }
  }
  void calcVerts(int step) {
    verts[0] = (offset + (ajnt[0] != null ? ajnt[0].offset : 0) + (ajnt[1] != null ? ajnt[1].offset : 0) + (ajnt[2] != null ? ajnt[2].offset : 0)) /
                (1 + int(ajnt[0] != null) + int(ajnt[1] != null) + int(ajnt[2] != null));
    verts[1] = (offset + (ajnt[2] != null ? ajnt[2].offset : 0) + (ajnt[3] != null ? ajnt[3].offset : 0) + (ajnt[4] != null ? ajnt[4].offset : 0)) /
                (1 + int(ajnt[2] != null) + int(ajnt[3] != null) + int(ajnt[4] != null));
    verts[2] = (offset + (ajnt[4] != null ? ajnt[4].offset : 0) + (ajnt[5] != null ? ajnt[5].offset : 0) + (ajnt[6] != null ? ajnt[6].offset : 0)) /
                (1 + int(ajnt[4] != null) + int(ajnt[5] != null) + int(ajnt[6] != null));
    verts[3] = (offset + (ajnt[6] != null ? ajnt[6].offset : 0) + (ajnt[7] != null ? ajnt[7].offset : 0) + (ajnt[0] != null ? ajnt[0].offset : 0)) /
                (1 + int(ajnt[6] != null) + int(ajnt[7] != null) + int(ajnt[0] != null));
    if (step > 0) {
      for (int i = 0; i < ajnt.length; i++) {
        if (ajnt[i] != null) {
          ajnt[i].ajnt[(i + 4) % ajnt.length] = this;
          ajnt[i].calcVerts(step - 1);
        }
      }
    }
  }
  public void delete() {
    
  }
  public String toString() {
    return "TerrTile[" + num + "]Off[" + offset + "]";
  }
}