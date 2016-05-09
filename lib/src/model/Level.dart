import 'package:DartWeb/model/GameObject.dart';
import 'package:DartWeb/model/Brick.dart';
import 'package:DartWeb/model/Item.dart';

///
/// Ein [Level] ist ein Level im Spiel
///
/// Enthält alle [Brick] die zuvor generiert wurden. Diese werden aus der Config
/// generiert die in [_readLevel] übergeben werden vom Constructor
///
class Level {

  ///
  /// Breite des Spielfelds
  ///
  int _width;
  ///
  /// Länge des Spielfelds
  ///
  int _length;
  ///
  /// Anzahl der positiven [Item] die dieses Level enthält
  ///
  int _countPositiveItems;
  ///
  /// Anzahl der negativen [Item] die dieses Level enthält
  ///
  int _countNegativeItems;
  ///
  /// Enthält das gesamte Spielfeld als 2d Liste
  ///
  /// Felder ohne ein relevantes Objekt enthalten einfach nur die Oberklasse
  /// [GameObject] andere Felder haben dementsprechend [Ball],[Brick],[Item]
  /// oder [Player]
  ///
  List<List<GameObject>> _gameField;
  ///
  /// Generiert das Level aus der übergebenen [config]
  ///
  void _readLevel(String config){
    //TODO: Implement Method
  }
  ///
  /// Setzt einen [Brick]
  ///
  void _setBrick(){
    //TODO: Implement Method
  }
  ///
  /// Zerstört einen [Brick] an der angegebenen Position
  ///
  /// Kann ein [Item] liefern wenn dieser [Brick] ein Item enthielt
  ///
  Item removeBrick(Brick brick){
    //TODO: Implement Method
  }

}