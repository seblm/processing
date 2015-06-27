package name.lemerdy.sebastian.triviaclient; // TODO ajouter la déclaration du package

import com.sun.net.httpserver.HttpServer;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

class EventsListener {
  private final TriviaClient client;

  EventsListener(TriviaClient client) {
    this.client = client;
  }

  void emit(String line) {
    Matcher matcher = Pattern.compile("(.+) was added").matcher(line);
    if (matcher.matches()) {
      client.playerWasAdded(matcher.group(1));
      return;
    }
    System.out.println(line + " is not yet handled");
  }

  void start() {
    try {
      HttpServer httpServer = HttpServer.create(new java.net.InetSocketAddress("localhost", 1981), 0);
      httpServer.createContext("/event", new com.sun.net.httpserver.HttpHandler() {
        public void handle(com.sun.net.httpserver.HttpExchange context) {
          if (!"POST".equals(context.getRequestMethod())) {
            return;
          }
          BufferedReader body = null;
          String currentLine;
          try {
            body = new BufferedReader(new java.io.InputStreamReader(context.getRequestBody()));
            while ((currentLine = body.readLine()) != null) {
              emit(currentLine);
            }
          } catch (IOException e) {
            e.printStackTrace();
          } finally {
            if (body != null) {
              try {
                body.close();
              } catch (IOException e) {
                e.printStackTrace();
              }
            }
          }
          try {
            context.sendResponseHeaders(200, -1);
          } catch (IOException e) {
            e.printStackTrace();
          }
          context.close();
        }
      });
      httpServer.start();
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

  static EventsListener handleEvents(TriviaClient client) {
    return new EventsListener(client);
  }
}
