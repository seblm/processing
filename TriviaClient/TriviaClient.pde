private final int WIDTH = 1024;
private final int HEIGHT = 768;
private final int NUMBER_OF_LOCATIONS = 12;

private final int X_CENTER = WIDTH / 2;
private final int Y_CENTER = HEIGHT / 2;
private final int BOARD_SIZE = max(WIDTH / 3, HEIGHT / 3);
private final int BOARD_THICKNESS = BOARD_SIZE / 3;
private final float ANGLE = 2 * PI / NUMBER_OF_LOCATIONS;
private final int CARD_WIDTH = min(WIDTH, HEIGHT) / 20;
private final int CARD_HEIGHT = max(WIDTH, HEIGHT) / 20;

void setup() {
  size(WIDTH, HEIGHT);
  noLoop();
}

void draw() {
  for (int factor = 0; factor < NUMBER_OF_LOCATIONS; factor++) {
    Category category = Category.fromIndex(factor);
    fill(category.red, category.green, category.blue);
    arc(X_CENTER, Y_CENTER,
        BOARD_SIZE, BOARD_SIZE,
        factor * ANGLE - ANGLE/2, (factor + 1) * ANGLE - ANGLE/2,
        PIE);
  }

  fill(200);
  ellipse(X_CENTER, Y_CENTER, BOARD_SIZE - BOARD_THICKNESS, BOARD_SIZE - BOARD_THICKNESS);

  int x = 2;
  for (Category category : Category.values()) {
    fill(category.red, category.green, category.blue);
    for (int i = 0; i < 50; i++) {
      rect(x + i*2, HEIGHT - CARD_HEIGHT - 2, CARD_WIDTH, CARD_HEIGHT);
    }
    x += 100;
  }
}
