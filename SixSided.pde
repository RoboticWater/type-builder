public abstract class SixSided extends Entity {
  int sides = 0x3F;
  public SixSided(Class<?> c, int x, int y, int z) {
    if (x > 0) if (isOf(c, buildSpace[x - 1][y][z])) {
      sides &= ~(0x1);
      SixSided b = (SixSided)buildSpace[x - 1][y][z];
      b.sides &= ~(0x2);
    }
    if (x % buildSpace.length < buildSpace.length - 1) if (isOf(c, buildSpace[x + 1][y][z])) {
      sides &= ~(0x2);
      SixSided b = (SixSided)buildSpace[x + 1][y][z];
      b.sides &= ~(0x1);
    }
    if (y > 0) if(isOf(c, buildSpace[x][y - 1][z])) {
      sides &= ~(0x4);
      SixSided b = (SixSided)buildSpace[x][y - 1][z];
      b.sides &= ~(0x8);
    }
    if (y % buildSpace.length < buildSpace.length - 1) if (isOf(c, buildSpace[x][y + 1][z])) {
      sides &= ~(0x8);
      SixSided b = (SixSided)buildSpace[x][y + 1][z];
      b.sides &= ~(0x4);
    }
    if (z > 0) if(isOf(c, buildSpace[x][y][z - 1])) {
      sides &= ~(0x10);
      SixSided b = (SixSided)buildSpace[x][y][z - 1];
      b.sides &= ~(0x20);
    }
    if (z % buildSpace.length < buildSpace.length - 1) if (isOf(c, buildSpace[x][y][z + 1])) {
      sides &= ~(0x20);
      SixSided b = (SixSided)buildSpace[x][y][z + 1];
      b.sides &= ~(0x10);
    }
  }
}