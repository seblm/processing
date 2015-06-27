import java.util.Map;
import java.util.HashMap;

class Game {
  private final Map/*<String, Player>*/ players;

  Game() {
    this.players = new HashMap();
  }

  void playerWasAdded(String name) {
    players.put(name, new Player(name));
  }
}
