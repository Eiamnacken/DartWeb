
import 'Enums.dart';

class GameObject{
  ///
  /// X position des [MoveableObject] auf dem Spielfeld
  /// Zeigt immer den Mittelpunkt des [MoveableObject] an
  ///
  int _xPosition;

  ///
  /// Y position des [MoveableObject] auf dem Spielfeld
  /// Zeigt immer den Mittelpunkt des [MoveableObject] an
  ///
  int _yPosition;

  ///
  /// Die Breite des [MoveableObject]
  ///
  int _width;

  ///
  /// Die Länge des [MoveableObject]
  ///
  int _length;

  GameObject(this._xPosition, this._yPosition, this._width, this._length) {

  }


}

///
/// Objekte die sich im [Level] bewegen können
///
abstract class MoveableObject extends GameObject{
  ///
  /// Wie viel abstand legt ein [MoveableObject] pro zeiteinheit/tastendruck zurück
  ///
  int _moveSpeed;
  ///
  /// Bewegt ein [MoveableObject] in eine Richtung
  /// [direction] gibt an in welche richtung sich das Objekt bewegt
  /// [gameField] gibt die nötigen Informationen für die [collision]
  ///
  void move(Direction direction,List<List<GameObject>> gameField);

  ///
  /// Gibt an ob beim nächsten Schritt in diese Richtung eine kollision stattfinden wird
  ///
  bool collisionAhead(Direction direction,List<List<GameObject>> gameField);

  ///
  /// Tauscht den platz zwei [GameObject] im [gameField]
  ///
  ///
  void switchObjects(List<List<GameObject>> gameField, GameObject object1, GameObject object2){
    MoveableObject buffer = gameField.elementAt(object1._yPosition).removeAt(object1._xPosition);
    gameField.elementAt(object1._yPosition).insert(object1._yPosition,object2);
    gameField.elementAt(object2._yPosition).insert(object2._xPosition,buffer);
  }

  MoveableObject(this._moveSpeed) {

  }


}


