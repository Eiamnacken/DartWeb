part of brickGame;

///
/// Sind kleine rechtecke die auf dem Spielfeld platziert werden
/// Es ist Ziel des Spieles diese zu zerstören
///
class Brick extends GameObject {
  ///
  /// Gibt an ob dieser [Brick] ein Item enthält welches nach dem [destroy] freigelassen
  /// wird
  ///
  bool _containsItem;

  ///
  /// Größe der [Brick]
  ///
  int _size;

  ///
  /// Position auf der x-Achse zeigt auf den Mittelpunkt
  ///
  int _xPosition;

  ///
  /// Position auf der y-Achse zeigt auf den Mittelpunkt
  ///
  int _yPosition;

  ///
  /// Leben eines [Brick]
  ///
  Health health;

  Brick(int xPosition, int yPosition, int width, int length, String health)
      : super(xPosition, yPosition, width, length) {
    this.health = generateHealth(health);
  }

  ///
  /// Verringert die [health] um eine Stufe
  /// Wenn der [Brick] vorher auf [red] stand wird ein `false` zurück gegeben
  /// ansonsten `true`
  ///
  void decHealth(int damage, List<List<GameObject>> gameField) {
    health = getHealth(damage, health);
    if (health == Health.grey) {
      gameField[xPosition][yPosition] = null;
    }
    print(health);
  }

  ///
  /// Zerstört diesen [Brick] und prüft ob es ein [Item] enthält
  /// Gibt ein [Item] zurück wenn es eines enthält ansonsten null
  ///
  Item destroy() {
    return _release();
  }

  ///
  /// Legt ein neues [Item] an und gibt diese zurück
  ///
  Item _release() {
    return null;
  }

  @override
  void collision(List<List<GameObject>> gameField, GameObject collisionObject) {
    if (collisionObject is Ball) {
      print("col");
      decHealth(collisionObject.damage, gameField);
    } else
      return;
  }

  String toString() {
    String buffer="";
    switch(health){
      case Health.brown:
      buffer="brownBrick";
        break;
      case Health.green:
        buffer="greenBrick";
        break;
      case Health.grey:
        buffer="greyBrick";
        break;
      case Health.red:
        buffer="redBrick";
        break;
      case Health.yellow:
        buffer="yellowBrick";
        break;
    }
    return buffer;
  }


}
