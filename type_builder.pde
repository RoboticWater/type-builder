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
  //println(frameRate);
}
void keyPressed() {
  int x = cursor[0] % buildSpace.length;
  int y = cursor[1];
  int z = cursor[0] / buildSpace.length;
  if (key == 'b') {
    buildSpace[x][y][z] = new Box(x, y, z, 20, 20, 20, key);
  } else if (int(key) > 47 && int(key) < 58) {
    buildSpace[x][y][z] = new TerrainTile(x, y, z, key);
  } else if (key == ' ') {
    renderQuad = !renderQuad;
  } else if (key == 'q') {
    buildSpace[x][y][z] = new Tube(x, y, z, key);
  }
  if (keyCode == 8) {
    cursor[0]--;
    if (cursor[0] < 0) {
      cursor[1]--;
      cursor[0] = buildSpace.length * buildSpace.length - 1;
    }
    x = cursor[0] % buildSpace.length;
    y = cursor[1];
    z = cursor[0] / buildSpace.length;
    if (buildSpace[x][y][z] != null) buildSpace[x][y][z].delete();
    buildSpace[x][y][z] = null;
  }
  else {
    cursor[0]++;
    if (cursor[0] > buildSpace.length * buildSpace.length - 1) {
      cursor[1]--;
      cursor[0] = 0;
    }
  }
}

public boolean isOf(Class clazz, Object obj){
    return clazz.isInstance(obj);
}