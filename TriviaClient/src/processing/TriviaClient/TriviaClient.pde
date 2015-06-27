private final int WIDTH = 640;
private final int HEIGHT = 480;
private final int NUMBER_OF_LOCATIONS = 12;
private final int NUMBER_OF_QUESTIONS = 50;

private Game game;

@Override
void setup() {
  println(System.getProperty("java.version"));
  size(WIDTH, HEIGHT);
  noLoop();
  smooth();
  game = new Game();
}

@Override
void draw() {
  drawBoard();
  drawDeck();
  EventsListener.handleEvents(this).start();
}

private void drawBoard() {
  final int xCenter = WIDTH / 2,
            yCenter = HEIGHT / 2,
            size = max(WIDTH / 3, HEIGHT / 3),
            thickness = size / 3;
  final float angle = 2 * PI / NUMBER_OF_LOCATIONS;

  pushMatrix();
  translate(xCenter, yCenter);
  startLocationAtNorth();
  startLocationCentered(angle);

  for (int factor = 0; factor < NUMBER_OF_LOCATIONS; factor++) {
    Category category = Category.fromIndex(factor);
    category.fill(this);
    arc(0, 0,
        size, size,
        factor * angle, (factor + 1) * angle,
        PIE);
  }

  fill(200);
  ellipse(0, 0, size - thickness, size - thickness);

  popMatrix();
}

private void drawDeck() {
  final int cardWidth = min(WIDTH, HEIGHT) / 20,
            cardHeight = max(WIDTH, HEIGHT) / 20,
            deckWidthForOneCategory = NUMBER_OF_QUESTIONS * 2 + cardWidth,
            deckWidth = deckWidthForOneCategory * Category.values().length;

  pushMatrix();
  translate((WIDTH - deckWidth) / 2, HEIGHT - cardHeight - 2);
  for (Category category : Category.values()) {
    category.fill(this);
    for (int x = NUMBER_OF_QUESTIONS * 2; x > 0; x -= 2) {
      rect(x, 0, cardWidth, cardHeight);
    }
    translate(deckWidthForOneCategory, 0);
  }
  popMatrix();
}

void playerWasAdded(String name) {
  game.playerWasAdded(name);
  println(name);
}

private void startLocationAtNorth() {
  rotate(-PI/2);
}

private void startLocationCentered(float angle) {
  rotate(-angle/2);
}
