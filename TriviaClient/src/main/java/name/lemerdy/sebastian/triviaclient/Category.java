package name.lemerdy.sebastian.triviaclient;

import processing.core.PApplet;

public enum Category {

  POP(200, 67, 67),
  SCIENCE(97, 142, 200),
  SPORTS(77, 188, 30),
  ROCK(51, 41, 51);

  public final int red;
  public final int green;
  public final int blue;

  Category(int red, int green, int blue) {
    this.red = red;
    this.green = green;
    this.blue = blue;
  }

  public void fill(PApplet context) {
    context.fill(red, green, blue);
  }

  public static Category fromIndex(int index) {
    return Category.values()[index % Category.values().length];
  }

}
