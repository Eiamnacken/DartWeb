import 'Model.dart';

///
/// Enthält alle objekte die sich momentan im Spiel befinden und stellt
/// Funktionen zu dessen bewegung zu verfügung. Lädt außerdem das Level und
/// deren Inhalt.
/// Für nähere Informationen siehe Dokumentation der Funktionen und Attribute
///
class Game {
  ///
  /// Enthält die angabe für den Positiven [Effekt] [longerPLayer] wird zum Start
  /// festgelegt
  ///
  int _incLength;

  ///
  /// Enthält die angabe für den negativen [Effekt] [smallerPlayer] wird zum Start
  /// festgelegt
  ///
  int _decLength;

  ///
  /// Enthält die angabe für den negativen [Effekt] [slowerPLayer] wird zum Start
  /// festgelegt
  ///
  int _decSpeedPLayer;

  ///
  /// Enthält die angabe für den positiven [Effekt] [damageBall] wird zum Start
  /// festgelegt
  ///
  int _incDamageBall;

  ///
  /// Enthält alle [MoveableObject] die sich auf der Karte befinden
  ///
  List<MoveableObject> objects;

  ///
  /// Die level
  ///
  List<GameField> gameFields;

  ///
  /// Alle [Ball] objekte  objekte werden um ihren [_moveSpeed] bewegt
  ///
  void moveBalls() {}

  ///
  /// Alle [Item] objekte werden um ihren [_moveSpeed] bewegt
  ///
  void moveItems() {}

  ///
  /// Bewegt den [Player] in die richtung von [x]
  /// [x]   Die richtung in die der Spieler sich bewegt
  ///
  void movePLayer(int x) {}

  ///
  /// Bereitet das nächste level vor in [GameField]
  ///
  void nextLevel() {}

  ///
  /// Aktiviert ein [Item] auf den [PLayer]
  ///
  void _activateItem() {}

  ///
  /// Kümmert sich um kollisioen des [Ball] mit anderen Objekten
  ///
  void _collisionBall() {}

  ///
  /// Kümmert sich um kollisionen des [Item] mit anderen Objekten
  ///
  void _collisionItem() {}

  ///
  /// Kümmert sich um die kollisioen des [PLayer] mit anderen Objekten
  ///
  void _collisionPLayer() {}

  ///
  /// Ließt die Json Config um die darin enthaltenen Level anzulgegen
  ///
  void _readConfig() {}

  ///
  /// LÖscht ein [MoveableObject] aus dem Spiel
  ///
  void _removeObject(MoveableObject object) {}

  ///
  /// Setzt alle werte auf den Standard zurück
  ///
  void _resetState() {}
}
