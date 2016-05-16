part of brickGame;

///
/// Enthält alle objekte die sich momentan im Spiel befinden und stellt
/// Funktionen zu dessen bewegung zu verfügung. Lädt außerdem das Level und
/// deren Inhalt.
/// Für nähere Informationen siehe Dokumentation der Funktionen und Attribute
///
class Game {
  ///
  /// Enthält die angabe für den Positiven [Effect] [longerPLayer] wird zum Start
  /// festgelegt
  ///
  int _incLength;

  ///
  /// Enthält die angabe für den negativen [Effect] [smallerPlayer] wird zum Start
  /// festgelegt
  ///
  int _decLength;

  ///
  /// Enthält die angabe für den negativen [Effect] [slowerPLayer] wird zum Start
  /// festgelegt
  ///
  int _decSpeedPLayer;

  ///
  /// Enthält die angabe für den positiven [Effect] [damageBall] wird zum Start
  /// festgelegt
  ///
  int _incDamageBall;

  ///
  /// In welchem [Level] befinden wir uns
  ///
  int countLevel;

  ///
  /// Die level
  ///
  List<Level> gameFields;

  Game() {
    gameFields = new List();
    _readConfig();
    countLevel=gameFields.length-1;
  }

  ///
  /// Bewegt alle Bälle um einen Schritt
  /// [direction] In welche Richtung soll sich der [Ball] bewegen
  ///
  void moveBall(GameController controller) {
    print("Move");
    List balls = gameFields[countLevel].balls;
    if(balls.isNotEmpty) {
      balls.forEach((ball) {
        ball.move(
            ball.direction, gameFields[countLevel].gameField, controller);
        if (ball.yPosition <= 0 ) {
          gameFields[countLevel].balls.remove(ball);
        }
      });
    }
  }

  ///
  /// Bewegt alle Items um einen Schritt
  /// [direction] in welche richtung soll es sich bewegen
  ///
  ///
  void moveItem(GameController controller) {
    gameFields[countLevel].items.forEach((item) {
      item.move(
          Direction.down, gameFields[countLevel].gameField, controller);
      if (item.yPosition <= 0) {
        gameFields[countLevel].items.remove(item);
      }
    });
  }

  ///
  /// Bewegt den [Player] in die richtung von [x]
  /// [direction]   Die richtung in die der Spieler sich bewegt
  ///
  void movePLayer(Direction direction, GameController controller) {
    Player player = _getPlayer();

    //for (int i = player.moveSpeed; i > 0; i--) {
      player.move(direction, gameFields[countLevel].gameField, controller);
    //}
  }

  Player _getPlayer() {
    return gameFields[countLevel].player;
  }

  bool gameOver() {
    if (gameFields[countLevel].balls.length == 0) {
      return true;
    }
    return false;
  }

  bool won() {
    if (gameFields[countLevel].bricks.length == 0 &&
        gameFields[countLevel].balls.length > 0) {
      return true;
    }
    return false;
  }

  ///
  /// Bereitet das nächste level vor in [Level]
  ///
  void newLevel() {}

  ///
  /// Ließt die Json Config um die darin enthaltenen Level anzulgegen
  ///
  void _readConfig() {
    /// liest .json aus einem Ordner in einen String
    ///
    String jsonDataAsString = '''
    { "playerHeight":1,
      "playerLength":1,
      "brickHeight":1,
      "brickLength":1,
      "ballHeight":1,
      "ballLength":1,
      "ballSpeed":250,
      "playerSpeed":750,
      "itemSpeed":250,
      "countPosItems":0,
      "countNegItems":0,
      "levelLength":10,
      "levelHeight":24,
      "levelField":[["empty", "empty", "greenbrick", "yellowbrick", "redbrick", "redbrick", "yellowbrick", "greenbrick", "empty", "empty"],
                    ["empty", "empty", "greenbrick", "yellowbrick", "redbrick", "yellowbrick", "greenbrick", "greenbrick", "empty", "empty"],
                    ["empty", "empty", "greenbrick", "yellowbrick", "redbrick", "yellowbrick", "greenbrick", "empty", "empty", "empty"],
                    ["empty", "empty", "greenbrick", "yellowbrick", "redbrick", "yellowbrick", "greenbrick", "empty", "empty", "empty"],
                    ["empty", "empty", "greenbrick", "yellowbrick", "redbrick", "yellowbrick", "greenbrick", "empty", "empty", "empty"],
                    ["empty", "empty", "greenbrick", "yellowbrick", "redbrick", "yellowbrick", "greenbrick", "empty", "empty", "empty"],
                    ["empty", "redbrick", "redbrick", "redbrick", "redbrick", "redbrick", "redbrick", "redbrick", "redbrick", "empty"],
                    ["empty", "empty", "greenbrick", "greenbrick", "greenbrick", "greenbrick", "greenbrick", "greenbrick", "empty", "empty"],
                    ["empty", "empty", "greenbrick", "yellowbrick", "redbrick", "yellowbrick", "greenbrick", "empty", "empty", "empty"],
                    ["empty", "empty", "empty", "empty", "redbrick", "yellowbrick", "greenbrick", "empty", "empty", "empty"],
                    ["empty", "empty", "greenbrick", "yellowbrick", "redbrick", "yellowbrick", "greenbrick", "empty", "empty", "empty"],
                    ["empty", "empty", "greenbrick", "yellowbrick", "redbrick", "yellowbrick", "greenbrick", "empty", "empty", "empty"],
                    ["empty", "empty", "greenbrick", "yellowbrick", "redbrick", "yellowbrick", "greenbrick", "empty", "empty", "empty"],
                    ["empty", "greenbrick", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
                    ["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
                    ["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
                    ["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
                    ["redbrick", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "redbrick"],
                    ["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
                    ["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
                    ["empty", "empty", "empty", "empty", "ball", "empty", "empty", "empty", "empty", "empty"],
                    ["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
                    ["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
                    ["empty", "empty", "empty", "empty", "player", "empty", "empty", "empty", "empty", "empty"]]
    }
    ''';

    Level level = new Level();

    level.readLevel(jsonDataAsString);
    gameFields.add(level);
  }

  ///
  /// Löscht ein [MoveableObject] aus dem Spiel
  ///
  void _removeObject(MoveableObject object) {}

  ///
  /// Setzt alle werte auf den Standard zurück
  ///
  void _resetState() {}
}
