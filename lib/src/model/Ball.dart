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
      : super(xPosition, yPosition, width, length, moveSpeed){
    _direction=Direction.rightUp;
    _damage=1;
  }

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
    _moveSpeed = speed;
  }

  ///
  /// Wird nur von Objekten aufgerufen die bei ihrer eigenen bewegung mit dem [Ball kolidieren
  ///
  void collision(List<List<GameObject>> gameField, GameObject collisionObject) {
    print("collision");
    _changeDirection(this._direction, collisionObject,gameField,{"X":0,"Y":0});
  }

  ///
  /// Wird nur von [move] und [collision] angesprochen
  ///
  /// Ändert die richtung in die der Ball fliegt
  /// [collisionObject] anhand dieses Objektes wird entschieden wie sich der [Ball] nach der kollision verhält
  ///
  ///
  void _changeDirection(Direction direction, GameObject collisionObject,List<List<GameObject>> gameField,Map<String,int> step) {
//    if(collisionObject is Player){
//
//    }else{
  //TODO Player beeinflusst flug richtung so kann es auch einen ball geben der direkt nach oben fliegt
    int width = gameField.length-1;
    int height = gameField[width].length-1;
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
        if(collisionObject != null){
          _direction=Direction.rightUp;
        }else _direction=Direction.leftDown;
        break;
      case Direction.rightUp:
        if(yPosition>=height) {
          _direction = Direction.rightDown;
        }else _direction=Direction.leftUp;
        break;
      case Direction.leftDown:
        if(collisionObject != null) {
          _direction = Direction.rightDown;
        }else _direction = Direction.leftUp;
        break;
      case Direction.leftUp:
        if(yPosition>=height) {
          _direction=Direction.leftDown;
        }else _direction=Direction.rightUp;
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
      switchObjects(gameField, xCoordinate, yCoordinate);
      xPosition += coordinates["X"];
      yPosition += coordinates["Y"];
      controller.updateView(gameField);
    } else {
      print(_direction);
      _changeDirection(direction, response[true],gameField,coordinates);
      if (response[true] != null){
        print(damage);
        response[true].collision(gameField, this);
      }
      print(_direction);
      move(_direction, gameField, controller);
    }
  }

  String toString() {
    return "ball";
  }


}
