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

  int points=0;

  ///
  /// Die level
  ///
  List<Level> gameFields;

  Game() {
    gameFields = new List();
    countLevel = 0;
    _readConfig();
  }

  ///
  /// Bewegt alle Bälle um einen Schritt
  /// [direction] In welche Richtung soll sich der [Ball] bewegen
  ///
  void moveBall(GameController controller) {
    List balls = gameFields[countLevel].balls;
    if (balls.isNotEmpty) {
      balls.forEach((ball) {
        ball.move(
            ball.direction, gameFields[countLevel].gameField, controller);
        if (ball.yPosition == _getPlayer().yPosition) {
          gameFields[countLevel].balls.removeLast();
          gameFields[countLevel].gameField[ball.xPosition][ball.yPosition] =
          null;
          controller.updateView(gameFields[countLevel].gameField);
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
    if (!gameOver()) {
      for (int i = player.moveSpeed; i > 0; i--) {
        player.move(direction, gameFields[countLevel].gameField, controller);
      }
    }
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
  void newLevel() {
    countLevel++;
  }

  void increasePoints(Health health){
    if(health==Health.brown) return;
    points += Health.values.indexOf(health)*10;
  }

  ///
  /// Ließt die Json Config um die darin enthaltenen Level anzulgegen
  ///
  void _readConfig() {
    /// liest .json aus einem Ordner in einen String
    ///
    String level0 = '''
    { "playerHeight":10,
      "playerLength":30,
      "brickHeight":10,
      "brickLength":10,
      "ballHeight":10,
      "ballLength":10,
      "ballSpeed":250,
      "playerSpeed":1,
      "itemSpeed":250,
      "countPosItems":0,
      "countNegItems":0,
      "levelLength":9,
      "levelHeight":16,
      "levelField":[["empty", "empty", "empty", "greenbrick", "greenbrick", "greenbrick", "empty", "empty", "empty"],
					["empty", "empty", "empty", "greenbrick", "greenbrick", "greenbrick", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "greenbrick", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "greenbrick", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "ball", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "player", "empty", "empty", "empty", "empty"]]
    }
    ''';

    String level1 = '''
    { "playerHeight":10,
      "playerLength":25,
      "brickHeight":10,
      "brickLength":10,
      "ballHeight":10,
      "ballLength":10,
      "ballSpeed":250,
      "playerSpeed":750,
      "itemSpeed":250,
      "countPosItems":0,
      "countNegItems":0,
      "levelLength":9,
      "levelHeight":16,
      "levelField":[["empty", "greenbrick", "greenbrick", "yellowbrick", "redbrick", "yellowbrick", "greenbrick", "greenbrick", "empty"],
					["empty", "empty", "greenbrick", "greenbrick", "yellowbrick", "greenbrick", "greenbrick", "empty", "empty"],
					["empty", "empty", "empty", "greenbrick", "greenbrick", "greenbrick", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "greenbrick", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "ball", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "player", "empty", "empty", "empty", "empty"]]
    }
    ''';

    String level2 = '''
    { "playerHeight":10,
      "playerLength":25,
      "brickHeight":10,
      "brickLength":10,
      "ballHeight":10,
      "ballLength":10,
      "ballSpeed":250,
      "playerSpeed":750,
      "itemSpeed":250,
      "countPosItems":0,
      "countNegItems":0,
      "levelLength":9,
      "levelHeight":16,
      "levelField":[["empty", "empty", "empty", "yellowbrick", "yellowbrick", "yellowbrick", "empty", "empty", "empty"],
					["empty", "empty", "yellowbrick", "redbrick", "empty", "redbrick", "yellowbrick", "empty", "empty"],
					["empty", "yellowbrick", "redbrick", "empty", "empty", "empty", "redbrick", "yellowbrick", "empty"],
					["yellowbrick", "redbrick", "empty", "empty", "empty", "empty", "empty", "redbrick", "yellowbrick"],
					["yellowbrick", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "yellowbrick"],
					["yellowbrick", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "yellowbrick"],
					["yellowbrick", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "yellowbrick"],
					["yellowbrick", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "yellowbrick"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "ball", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "player", "empty", "empty", "empty", "empty"]]
    }
    ''';

    String level3 = '''
    { "playerHeight":10,
      "playerLength":25,
      "brickHeight":10,
      "brickLength":10,
      "ballHeight":10,
      "ballLength":10,
      "ballSpeed":250,
      "playerSpeed":750,
      "itemSpeed":250,
      "countPosItems":0,
      "countNegItems":0,
      "levelLength":9,
      "levelHeight":16,
      "levelField":[["redbrick", "greenbrick", "redbrick", "greenbrick", "redbrick", "greenbrick", "redbrick", "greenbrick", "redbrick"],
					["yellowbrick", "yellowbrick", "yellowbrick", "yellowbrick", "yellowbrick", "yellowbrick", "yellowbrick", "yellowbrick", "yellowbrick"],
					["redbrick", "redbrick", "redbrick", "empty", "empty", "empty", "redbrick", "redbrick", "redbrick"],
					["greenbrick", "greenbrick", "empty", "empty", "empty", "empty", "empty", "greenbrick", "greenbrick"],
					["greenbrick", "greenbrick", "empty", "empty", "empty", "empty", "empty", "greenbrick", "greenbrick"],
					["greenbrick", "greenbrick", "empty", "empty", "empty", "empty", "empty", "greenbrick", "greenbrick"],
					["redbrick", "redbrick", "redbrick", "empty", "empty", "empty", "redbrick", "redbrick", "redbrick"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "ball", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "player", "empty", "empty", "empty", "empty"]]
    }
    ''';

    String level4 = '''
    { "playerHeight":10,
      "playerLength":25,
      "brickHeight":10,
      "brickLength":10,
      "ballHeight":10,
      "ballLength":10,
      "ballSpeed":250,
      "playerSpeed":750,
      "itemSpeed":250,
      "countPosItems":0,
      "countNegItems":0,
      "levelLength":9,
      "levelHeight":16,
      "levelField":[["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "redbrick"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "redbrick", "yellowbrick"],
					["empty", "empty", "empty", "empty", "empty", "empty", "redbrick", "yellowbrick", "greenbrick"],
					["empty", "empty", "empty", "empty", "empty", "redbrick", "yellowbrick", "greenbrick", "empty"],
					["empty", "empty", "empty", "empty", "redbrick", "yellowbrick", "greenbrick", "empty", "empty"],
					["empty", "empty", "empty", "redbrick", "yellowbrick", "greenbrick", "empty", "empty", "empty"],
					["empty", "empty", "redbrick", "yellowbrick", "greenbrick", "empty", "empty", "empty", "empty"],
					["empty", "redbrick", "yellowbrick", "greenbrick", "empty", "empty", "empty", "empty", "empty"],
					["redbrick", "yellowbrick", "greenbrick", "empty", "empty", "empty", "empty", "empty", "empty"],
					["yellowbrick", "greenbrick", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["greenbrick", "empty", "empty", "empty", "ball", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
					["empty", "empty", "empty", "empty", "player", "empty", "empty", "empty", "empty"]]
    }
    ''';

    List<String> levelsAsJson = new List<String>();
    levelsAsJson.add(level0);
    levelsAsJson.add(level1);
    levelsAsJson.add(level2);
    levelsAsJson.add(level3);
    levelsAsJson.add(level4);

    for(int i = 0; i < levelsAsJson.length; i++) {
      Level level = new Level();
      level.readLevel(levelsAsJson[i]);
      gameFields.add(level);
    }
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
