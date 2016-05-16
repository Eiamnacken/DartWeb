
part of brickGame;

abstract class GameObject{
  ///
  /// X position des [MoveableObject] auf dem Spielfeld
  /// Zeigt immer den Mittelpunkt des [MoveableObject] an
  ///
  int xPosition;

  ///
  /// Y position des [MoveableObject] auf dem Spielfeld
  /// Zeigt immer den Mittelpunkt des [MoveableObject] an
  ///
  int yPosition;

  ///
  /// Die Breite des [MoveableObject]
  ///
  int width;

  ///
  /// Die Länge des [MoveableObject]
  ///
  int length;

  GameObject(this.xPosition, this.yPosition, this.width, this.length);

  ///
  /// Wird aufgerufen wenn eine Kollision mit diesem Objekt entsteht
  ///
  void collision(List<List<GameObject>> gameField,GameObject collisionObject);

}

///
/// Objekte die sich im [Level] bewegen können
///
abstract class MoveableObject extends GameObject{
  ///
  /// Wie viel abstand legt ein [MoveableObject] pro zeiteinheit/tastendruck zurück
  ///
  int moveSpeed;

  MoveableObject(int xPosition, int yPosition, int width, int length,this.moveSpeed): super(xPosition, yPosition, width, length);

  ///
  /// Bewegt ein [MoveableObject] in eine Richtung
  /// [direction] gibt an in welche richtung sich das Objekt bewegt
  /// [gameField] gibt die nötigen Informationen für die [collision]
  ///
  void move(Direction direction,List<List<GameObject>> gameField,GameController controller);

  ///
  /// Gibt an ob beim nächsten Schritt in diese Richtung eine kollision stattfinden wird
  ///
  /// Wenn der [Player] auf den [Ball] trifft gibt es einen `{false:Ball}` zurück
  /// Ist das ende des Levels erreicht gibt es ein `{true:null}` zurück
  ///
  ///
  Map<bool,GameObject> collisionAhead(Direction direction,List<List<GameObject>> gameField,[int y=0,int x=0]){
    GameObject buffer;
    //Für die grenzen des Spielfeldes
    if(xPosition+x==gameField.length||xPosition+x==0){
      return {true:null};
    }if(yPosition+y==gameField[0].length||yPosition+y==0){
      return {true:null};
    }
    try{
      buffer = gameField[xPosition+x][yPosition+y];
    }on RangeError{
      buffer =null;
    }

    if(buffer==null){
      return {false:null};
    }if(this is Player&&buffer is Ball){
      return {false:buffer};
    }
    return {true:buffer};
  }

  ///
  /// Tauscht den platz zwei [GameObject] im [gameField]
  ///
  /// Diese Methode braucht überarbeitung für flüssige bewegungen
  /// [x] momentane Position des Objekts mit dem dieses Objekt die position tauscht
  /// [y] Dito
  ///
  ///
  void switchObjects(List<List<GameObject>> gameField,[int x=0,int y=0]){
    MoveableObject buffer;
    try{
      buffer = gameField[xPosition][yPosition];
    }on RangeError{
      return;
    }

    gameField[xPosition][yPosition]= null;
    gameField[x][y]=buffer;
  }




}


