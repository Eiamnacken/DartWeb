
import 'package:DartWeb/src/model/GameObject.dart';
import 'package:DartWeb/src/model/Enums.dart';
import 'package:DartWeb/src/model/Item.dart';

///
/// Sind kleine rechtecke die auf dem Spielfeld platziert werden
/// Es ist Ziel des Spieles diese zu zerstören
///
class Brick extends GameObject{
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

  Brick(int xPosition, int yPosition, int width, int length) : super(xPosition, yPosition, width, length);

  ///
  /// Verringert die [health] um eine Stufe
  /// Wenn der [Brick] vorher auf [red] stand wird ein `false` zurück gegeben
  /// ansonsten `true`
  ///
  bool decHealth(int damage,List<List<GameObject>> gameField) {
    //TODO: Implement Method
  }

  ///
  /// Zerstört diesen [Brick] und prüft ob es ein [Item] enthält
  /// Gibt ein [Item] zurück wenn es eines enthält ansonsten null
  ///
  Item destroy() {
    //TODO: Implement Method
  }

  ///
  /// Legt ein neues [Item] an und gibt diese zurück
  ///
  Item _release() {
    //TODO: Implement Method
  }
}