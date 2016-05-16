part of brickGame;

///
/// Objekt das sich von selbst durch den Spielraum bewegt
/// Außerdem fügt es [Brick] schaden zu bei Kontakt
///
class Ball extends MoveableObject {
  ///
  /// Welchen schaden der [Ball] an einem [Brick] zufügt
  ///
  int _damage;

  Direction _direction;

  Ball(int xPosition, int yPosition, int width, int length, int moveSpeed)
      : super(xPosition, yPosition, width, length, moveSpeed);

  ///
  /// Ändert den [_damage] den ein [Ball] einem [Brick] zufügt
  ///
  void changeDamage(int damage) {
    _damage = damage;
  }

  Direction get direction => _direction;

  int get damage => _damage;

  ///
  /// Ändert die geschwindigkeit die der [Ball] pro zeiteinheit zurück legt
  ///
  void changeSpeed(int speed) {
    moveSpeed = speed;
  }

  ///
  /// Wird nur von Objekten aufgerufen die bei ihrer eigenen bewegung mit dem [Ball kolidieren
  ///
  void collision(List<List<GameObject>> gameField, GameObject collisionObject) {
    _changeDirection(this._direction, collisionObject);
  }

  ///
  /// Wird nur von [move] und [collision] angesprochen
  ///
  /// Ändert die richtung in die der Ball fliegt
  /// [collisionObject] anhand dieses Objektes wird entschieden wie sich der [Ball] nach der kollision verhält
  ///
  ///
  void _changeDirection(Direction direction, GameObject collisionObject) {
//    if(collisionObject is Player){
//
//    }else{
    switch (direction) {
      case Direction.up:
        break;
      case Direction.down:
        break;
      case Direction.left:
        break;
      case Direction.right:
        break;
      case Direction.rightDown:
        this._direction = Direction.rightUp;
        break;
      case Direction.rightUp:
        if (collisionObject == null)
          this._direction = Direction.leftUp;
        else
          this._direction = Direction.rightDown;
        break;
      case Direction.leftDown:
        this._direction = Direction.leftUp;
        break;
      case Direction.leftUp:
        if (collisionObject == null) {
          this._direction = Direction.rightUp;
        } else
          this._direction = Direction.leftDown;
        break;
    }
//    }
  }

  @override
  void move(Direction direction, List<List<GameObject>> gameField,
      GameController controller) {
    Map coordinates = getValuesForDirection(direction);
    final int xCoordinate = xPosition + coordinates["X"];
    final int yCoordinate = yPosition + coordinates["Y"];
    GameObject buffer;
    if (xCoordinate < gameField.length &&
        yCoordinate < gameField[xCoordinate].length) {
      buffer =
          gameField[xPosition + coordinates["X"]][yPosition + coordinates["Y"]];
    }
    Map response = collisionAhead(
        direction, gameField, coordinates["Y"], coordinates["X"]);
    //Kollison voraus ? wenn nicht einfach bewegen ansonsten werden die entsprechenden Schritte eingeleitet z.B. Kollision des Objekts aufgerufen
    if (!response.keys.first) {
      switchObjects(gameField, coordinates["X"], coordinates["Y"]);
      xPosition += coordinates["X"];
      yPosition += coordinates["Y"];
      print("Update");
      controller.updateView(gameField);
    } else {
      _changeDirection(direction, response[true]);
      if (response[true] != null) response[true].collision(gameField, this);
      move(direction, gameField, controller);
    }
  }
}
