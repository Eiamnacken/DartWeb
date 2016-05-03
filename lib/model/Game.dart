import 'Model.dart';

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

  ///
  /// Die level
  ///
  List<Level> gameFields;

  ///
  /// Bewegt einen Ball in eine Richtung
  /// [direction] In welche Richtung soll sich der [Ball] bewegen
  /// [ball]      Welcher [Ball] soll sich bewegen
  ///
  void moveBall(Direction direction, Ball ball) {}

  ///
  /// Bewegt ein Item in eine Richtung
  /// [direction] in welche richtung soll es sich bewegen
  /// [item]      Welches [Item] soll sich bewegen
  ///
  void moveItem(Direction direction, Item item) {}

  ///
  /// Bewegt den [Player] in die richtung von [x]
  /// [direction]   Die richtung in die der Spieler sich bewegt
  ///
  void movePLayer(Direction direction) {}

  ///
  /// Bereitet das nächste level vor in [Level]
  ///
  void newLevel() {}
  ///
  /// Ließt die Json Config um die darin enthaltenen Level anzulgegen
  ///
  void _readConfig() {}

  ///
  /// Löscht ein [MoveableObject] aus dem Spiel
  ///
  void _removeObject(MoveableObject object) {}

  ///
  /// Setzt alle werte auf den Standard zurück
  ///
  void _resetState() {}
}
