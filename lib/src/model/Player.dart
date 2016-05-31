part of brickGame;

/// Wird durch den Spieler Kontrolliert. Ein rechteck am unteren Rand des
/// des Spieles das den Ball reflektiert
///
class Player extends MoveableObject {


  Direction lastMove;


  Player(int xPosition, int yPosition, int width, int length, int moveSpeed)
      : super(xPosition, yPosition, width, length, moveSpeed,null);


  ///
  /// Ändert die Länge des [Player]
  ///
  void changeLength(int length) {
    length = length;
  }

  ///
  /// Ändert den Abstand den der [Player] pro tastendruck zurück legt
  ///
  void changeSpeed(int speed) {
    _moveSpeed = speed;
  }

  @override
  void move(Direction direction, List<List<GameObject>> gameField,
      GameController controller) {
    int x = getValuesForDirection(direction)["X"];
    Map response = collisionAhead(direction, gameField, 0, x);
    if (!response.keys.first) {
      if (response[false] != null) {
        response[false].collision(gameField, this);
      }

      switchObjects(gameField,this,response.values.first);


      controller.updateView(gameField);
    }
  }

  @override
  void collision(List<List<GameObject>> gameField, GameObject collisionObject) {
    return;
  }

  String toString() {
    return "player";
  }


}
