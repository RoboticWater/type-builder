import damkjer.ocd.*;
Camera cam;
PVector camTarg, camPos;
Entity[][][] buildSpace = new Entity[16][16][16];
ArrayList<Entity> entities = new ArrayList();
HashMap<Character, int[]> keyMap = new HashMap();
float xScale = 20, yScale = 20, zScale = 20;
int[] cursor = {0, buildSpace.length - 1};
boolean renderQuad = false;
void setup() {
  size(640, 480, P3D);
  cam = new Camera(this, width / 2, 0, width, width / 2, height / 2, 0);
}
void draw() {
  background(0);
  cam.feed();
  cam.circle(0.01);
  translate(width / 2 - buildSpace.length / 2 * xScale, 0, -zScale * buildSpace.length / 2);
  for (Entity e : entities) {
    e.draw();
  }
  //if (keyPressed) {
  //  if (key == 'b') {
  //    addBox(key); 
  //  } else if (key == 't') {
  //    addTerr(key);
  //  }
  //  cursor[0]++;
  //  if (cursor[0] > buildSpace.length * buildSpace.length - 1) {
  //    cursor[1]--;
  //    cursor[0] = 0;
  //  }
  //}
  for (int x = 0; x < buildSpace.length; x++) {
    for (int y = 0; y < buildSpace.length; y++) {
      for (int z = 0; z < buildSpace.length; z++) {
        if (buildSpace[x][y][z] != null) {
          pushMatrix();
          translate(x * xScale, y * yScale, z * zScale);
          buildSpace[x][y][z].draw();
          popMatrix();
        }
      }
    }
  }
  println(frameRate);
}
void keyPressed() {
  if (key == 'b') {
      addBox(key); 
    } else if (int(key) > 47 && int(key) < 58) {
      addTerr(key);
    } else if (key == ' ') {
      renderQuad = !renderQuad;
    }
    if (keyCode == 8) {
      cursor[0]--;
      if (cursor[0] < 0) {
        cursor[1]-=4;
        cursor[0] = buildSpace.length * buildSpace.length - 1;
      }
      int x = cursor[0] % buildSpace.length;
      int y = cursor[1];
      int z = cursor[0] / buildSpace.length;
      if (buildSpace[x][y][z] != null) buildSpace[x][y][z].delete();
      buildSpace[x][y][z] = null;
    }
    else {
      cursor[0]++;
      if (cursor[0] > buildSpace.length * buildSpace.length - 1) {
        cursor[1]-=4;
        cursor[0] = 0;
      }
    }
}
void addBox(char k) {
  int sides = 0x3F;
  int x = cursor[0] % buildSpace.length;
  int y = cursor[1];
  int z = cursor[0] / buildSpace.length;
  if (x > 0) if (buildSpace[x - 1][y][z] instanceof Box) {
    sides &= ~(0x1);
    Box b = (Box)buildSpace[x - 1][y][z];
    b.sides &= ~(0x2);
  }
  if (x % buildSpace.length < buildSpace.length - 1) if (buildSpace[x + 1][y][z] instanceof Box) {
    sides &= ~(0x2);
    Box b = (Box)buildSpace[x + 1][y][z];
    b.sides &= ~(0x1);
  }
  if (y > 0) if(buildSpace[x][y - 1][z] instanceof Box) {
    sides &= ~(0x4);
    Box b = (Box)buildSpace[x][y - 1][z];
    b.sides &= ~(0x8);
  }
  if (y % buildSpace.length < buildSpace.length - 1) if (buildSpace[x][y + 1][z] instanceof Box) {
    sides &= ~(0x8);
    Box b = (Box)buildSpace[x][y + 1][z];
    b.sides &= ~(0x4);
  }
  if (z > 0) if(buildSpace[x][y][z - 1] instanceof Box) {
    sides &= ~(0x10);
    Box b = (Box)buildSpace[x][y][z - 1];
    b.sides &= ~(0x20);
  }
  if (z % buildSpace.length < buildSpace.length - 1) if (buildSpace[x][y][z + 1] instanceof Box) {
    sides &= ~(0x20);
    Box b = (Box)buildSpace[x][y][z + 1];
    b.sides &= ~(0x10);
  }
  buildSpace[x][y][z] = new Box(20, 20, 20, sides, cursor[0]);
  //entities.add(new Box(cursor[0] % buildSpace.length, 20 - cursor[1], -cursor[0] / buildSpace.length, 20, 20, 20));
}
void addTerr(char key) {
  int x = cursor[0] % buildSpace.length;
  int y = cursor[1];
  int z = cursor[0] / buildSpace.length;
  boolean xb0 = x > 0;
  boolean xlr = x % buildSpace.length < buildSpace.length - 1;
  boolean zb0 = z > 0;
  boolean zlr = z % buildSpace.length < buildSpace.length - 1;
  TerrainTile[] ajnt = new TerrainTile[8]; 
  if (xb0) {
    if (buildSpace[x - 1][y][z] instanceof TerrainTile) ajnt[6] = (TerrainTile)buildSpace[x - 1][y][z];
    if (zb0) if (buildSpace[x - 1][y][z - 1] instanceof TerrainTile) ajnt[7] = (TerrainTile)buildSpace[x - 1][y][z - 1];
    if (zlr) if (buildSpace[x - 1][y][z + 1] instanceof TerrainTile) ajnt[5] = (TerrainTile)buildSpace[x - 1][y][z + 1];
  }
  if (xlr) {
    if (buildSpace[x + 1][y][z] instanceof TerrainTile) ajnt[2] = (TerrainTile)buildSpace[x + 1][y][z];
    if (zb0) if (buildSpace[x + 1][y][z - 1] instanceof TerrainTile) ajnt[1] = (TerrainTile)buildSpace[x + 1][y][z - 1];
    if (zlr) if (buildSpace[x + 1][y][z + 1] instanceof TerrainTile) ajnt[3] = (TerrainTile)buildSpace[x + 1][y][z + 1];
  }
  if (zb0) if(buildSpace[x][y][z - 1] instanceof TerrainTile) ajnt[0] = (TerrainTile)buildSpace[x][y][z - 1];
  if (zlr) if (buildSpace[x][y][z + 1] instanceof TerrainTile) ajnt[4] = (TerrainTile)buildSpace[x][y][z + 1];
  //println("N    NE   E    SE   S    SW   W    NW");
  //println(ajnt);
  buildSpace[x][y][z] = new TerrainTile(yScale + (int(key) - 48) * -7, ajnt);
}