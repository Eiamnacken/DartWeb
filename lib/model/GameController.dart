import 'Game.dart';
import 'dart:async';
import 'Model.dart';


///
/// Gibt an wie oft sich der [Ball] in einem Zeitraum bewegt hier alle 250 millisekunden
///
const ballSpeed= const Duration(milliseconds: 250);
///
/// Wie oft bewegt sich ein [Item]
///
const itemSpeed = ballSpeed;
///
/// Wie oft wird der GameKey geprüft
///
const gameKeyCheck = const Duration(seconds: 1);
///
/// Serveradresse des GameKeyServers
///
const gameKeyHost = "";
///
/// Portnummer des GameKeyServers
///
const gameKeyPort=9000;
///
/// Ist verantwortlich für alle bewegungen
///
/// Durch aufrufen der einzelnen move Funktionen werden die Objekte im Spiel bewegt
/// Bei [Ball] und [Item] passiert dies über einen [Timer].
/// Der [Player] wird gesteuert über Listener im GameView.
///
class GameController{

  ///
  /// Triggert die bewegung des [Ball] und ruft dessen [Ball] move methode auf
  ///
  Timer _ballTrigger;


}