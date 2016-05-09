import 'GameObject.dart';
import 'Enums.dart';

///
/// Objekt das sich von selbst durch den Spielraum bewegt
/// Außerdem fügt es [Brick] schaden zu bei Kontakt
///
class Ball extends MoveableObject {
  ///
  /// Welchen schaden der [Ball] an einem [Brick] zufügt
  ///
  int _damage;

  ///
  /// Ändert den [_damage] den ein [Ball] einem [Brick] zufügt
  ///
  void changeDamage(int damage) {
    //TODO: Implement Method
  }

  ///
  /// Ändert die geschwindigkeit die der [Ball] pro zeiteinheit zurück legt
  ///
  void changeSpeed(int speed) {
    //TODO: Implement Method
  }

  @override
  void collision(Direction direction, List<List<GameObject>> gameField) {
    // TODO: implement collision
  }
  ///
  /// Wird nur von [move()] angesprochen
  ///
  /// Ändert die richtung in die der Ball fliegt
  ///
  void _changeDirection(Direction direction){
    //TODO: Implement Method
  }
}