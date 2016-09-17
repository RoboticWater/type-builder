import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;
import damkjer.ocd.*;
Trail t;
ControlIO control;
ControlDevice stick;
Camera cam0, cam1;
PVector camTarg, camPos;
Entity[][][] buildSpace = new Entity[16][16][16];
ArrayList<Entity> entities = new ArrayList();
HashMap<Character, int[]> keyMap = new HashMap();
float xScale = 20, yScale = 20, zScale = 20;
int[] cursor = {0, buildSpace.length - 1};
boolean renderQuad = false, build = true, doCheck = true;
void setup() {
  size(640, 480, P3D);
  cam0 = new Camera(this, width / 2, 0, width, width / 2, height / 2, 0);
  cam1 = new Camera(this);
  control = ControlIO.getInstance(this);
  stick = control.getMatchedDevice("MacLayout");
  t = new Trail();
  if (stick == null) {
    println("No suitable device configured");
    System.exit(-1); // End the program NOW!
  }
}
void draw() {
  background(0);
  if (build) {
    cam0.feed();
    cam0.circle(0.01);
    if (!stick.getButton("BACK").pressed()) doCheck = true;
    if (stick.getButton("BACK").pressed() && doCheck) {
      build = false;
      doCheck = false;
    }
  } else {
    cam1.look(0.05 * stick.getSlider("LOOKX").getValue(), 0.05 * stick.getSlider("LOOKY").getValue());
    cam1.dolly(7*stick.getSlider("MOVEY").getValue());
    cam1.truck(7*stick.getSlider("MOVEX").getValue());
    cam1.feed();
    if (!stick.getButton("BACK").pressed()) doCheck = true;
    if (stick.getButton("BACK").pressed() && doCheck) {
      build = true;
      doCheck = false;
    }
  }  
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
  indicator();
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
  fill(#ff0000);
  box(0, 0, 0);
  //println(frameRate);
    t.draw();
}
void keyPressed() {
  int x = cursor[0] % buildSpace.length;
  int y = cursor[1];
  int z = cursor[0] / buildSpace.length;
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
  } else if (key == ';') {
    build = !build;
  } else if (key == ' ') {
    renderQuad = !renderQuad;
  } else {
    if (key == 'b') {
      buildSpace[x][y][z] = new Box(x, y, z, 20, 20, 20, key);
    } else if (int(key) > 47 && int(key) < 58) {
      buildSpace[x][y][z] = new TerrainTile(x, y, z, yScale + (key - 48) * -7);
    } else if (key == '-') {
      buildSpace[x][y][z] = new TerrainTile(x, y, z, yScale - 50*noise(x, z));
    } else if (key == '=') {
      buildSpace[x][y][z] = new TerrainTile(x, y, z, yScale - random(0, 50));
    }else if (key == 'q') {
      buildSpace[x][y][z] = new Tube(x, y, z, key);
    }
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

public void indicator() {
  int x = (cursor[0] + 1) % buildSpace.length;
  int y = cursor[1];
  int z = (cursor[0] + 1) / buildSpace.length;
  noFill();
  strokeWeight(2);
  stroke(#ff0000);
  pushMatrix();
  translate(x * xScale - xScale, y * yScale + yScale / 2 + yScale / 2 * sin(frameCount / 10.0), z * zScale);
  rotateX(HALF_PI);
  rect(0, 0, xScale, yScale);
  popMatrix();
  fill(255);
}

PVector rotateVectY(PVector v, float angle) {
  //Y
  return new PVector(v.x * cos(angle) + v.y * 0 + v.z * sin(angle),
                     v.x * 0 + v.y * 1 + v.z * 0,
                     v.x * -sin(angle)+ v.y * 0 + v.z * cos(angle));
}
PVector rotateVectX(PVector v, float angle) {
  return new PVector(v.x * 1 + v.y * 0 + v.z * 0,
                     v.x * 0 + v.y * cos(angle) + v.z * -sin(angle),
                     v.x * 0 + v.y * sin(angle) + v.z * cos(angle));
}
PVector rotateVectZ(PVector v, float angle) {
  return new PVector(v.x * cos(angle)+ v.y * -sin(angle),
                     v.x * sin(angle) + v.y * cos(angle),
                     v.z * 1);
}