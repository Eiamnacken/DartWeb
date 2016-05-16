part of brickGame;

///
/// Gibt an wie oft sich der [Ball] in einem Zeitraum bewegt hier alle 250 millisekunden
///
const ballSpeed = const Duration(milliseconds: 250);

///
/// Wie oft bewegt sich ein [Item]
///
const itemSpeed = ballSpeed;

///
/// Wie oft wird der GameKey geprüft
///
const gameKeyCheck = const Duration(seconds: 1);

///
/// Serveradresse des GameKeyServers
///
const gameKeyHost = "";

///
/// Portnummer des GameKeyServers
///
const gameKeyPort = 9000;

///
/// Ist verantwortlich für alle bewegungen
///
/// Durch aufrufen der einzelnen move Funktionen werden die Objekte im Spiel bewegt
/// Bei [Ball] und [Item] passiert dies über einen [Timer].
/// Der [Player] wird gesteuert über Listener im GameView.
///
class GameController {
  final Game game = new Game();

  final View view = new View();

  Timer _ballTrigger;

  GameController() {
    view.startButton.onClick.listen((_) {
      if (_ballTrigger != null) _ballTrigger.cancel();
      _ballTrigger = new Timer.periodic(ballSpeed, (_) => game.moveBall(this));
    });
    ButtonElement right = view.leftButton;
    right.onClick.listen((_) {
      if (game.gameOver()) return;
      game.movePLayer(Direction.right, this);
    });

    ButtonElement left = view.rightButton;
    left.onClick.listen((_) {
      if (game.gameOver()) return;
      game.movePLayer(Direction.left, this);
    });
    window.onKeyDown.listen((event) {
      if (game.gameOver()) return;
      if (event.keyCode == KeyCode.LEFT) {
        game.movePLayer(Direction.left, this);
      } else if (event.keyCode == KeyCode.RIGHT) {
        game.movePLayer(Direction.right, this);
      }
    });

    view.generateField(game);
  }

  void updateView(List<List<GameObject>> gameField) {
    game.gameFields[game.countLevel].gameField=gameField;
    view.update(game);
  }
}
